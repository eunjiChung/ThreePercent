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
    upload: S3.PresignedPost;
    refreshUrl: string;
}

function baseUrl(requestContext: APIGatewayEventRequestContext): string {
    const { domainName, stage } = requestContext;
    return `https://${domainName}/${stage}`;
}

async function main(event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> {
    event.requestContext.resourcePath;
    if (event.path === '/users' && event.httpMethod === 'POST') {
        const id = generateUniqueId();
        const presigned = await createPresignedPost(id);
        const body: CreateUserResponse = {
            id,
            upload: presigned,
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
