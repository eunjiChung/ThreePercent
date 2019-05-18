import { APIGatewayProxyEvent, APIGatewayProxyResult, APIGatewayProxyHandler } from 'aws-lambda';

async function main(event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> {
    return {
        statusCode: 404,
        body: `Not Found :P\n\n${event.path}`,
    };
}

export const handler: APIGatewayProxyHandler = (event, _context, callback) => {
    main(event)
        .then(res => callback(undefined, res))
        .catch(callback);
};
