import * as crypto from 'crypto';

import S3 = require('aws-sdk/clients/s3');
import {
    APIGatewayProxyEvent,
    APIGatewayProxyResult,
    APIGatewayProxyHandler,
    APIGatewayEventRequestContext,
} from 'aws-lambda';

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
const BUCKET_NAME: string = process.env['BUCKET_NAME']!;

const s3 = new S3();

export async function createPresignedPost(key: string): Promise<S3.PresignedPost> {
    return new Promise((resolve, reject) => {
        const params: S3.PresignedPost.Params = {
            Bucket: BUCKET_NAME,
            Fields: { key },
            Expires: 5 * 60,
        };
        s3.createPresignedPost(params, (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve(data);
            }
        });
    });
}

function generateUniqueId(): string {
    const bytes = crypto.randomBytes(20);
    return bytes.toString('hex');
}

interface CreateUserResponse {
    id: string;
    upload: PresignedPost;
    refreshUrl: string;
}

interface PresignedPost {
    url: string;
    fields: PresignedPostField[];
}

type PresignedPostField = [string, string];

const fieldOrder = [
    'key',
    'bucket',
    'acl',
    'success_action_redirect',
    'content-type',
    'x-amz-meta-uuid',
    'x-amz-server-side-encryption',
    'x-amz-credential',
    'x-amz-algorithm',
    'x-amz-date',
    'x-amz-security-token',
    'x-amz-meta-tag',
    'policy',
    'x-amz-signature',
];

function baseUrl(requestContext: APIGatewayEventRequestContext): string {
    const { domainName, stage } = requestContext;
    return `https://${domainName}/${stage}`;
}

async function main(event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> {
    event.requestContext.resourcePath;
    if (event.path === '/users' && event.httpMethod === 'POST') {
        const id = generateUniqueId();
        const { url, fields: fieldMap } = await createPresignedPost(id);
        for (const key of Object.keys(fieldMap)) {
            fieldMap[key.toLowerCase()] = fieldMap[key];
        }
        const fields: PresignedPostField[] = [];
        for (const key of fieldOrder) {
            if (fieldMap.hasOwnProperty(key)) {
                fields.push([key, fieldMap[key]]);
            }
        }

        const body: CreateUserResponse = {
            id,
            upload: { url, fields },
            refreshUrl: `${baseUrl(event.requestContext)}/users/${id}/refresh`,
        };
        return {
            statusCode: 201,
            body: JSON.stringify(body),
        };
    }

    return {
        statusCode: 404,
        body: '{}',
    };
}

export const handler: APIGatewayProxyHandler = (event, _context, callback) => {
    main(event)
        .then(res => callback(undefined, res))
        .catch(callback);
};
