import * as path from 'path';

import cdk = require('@aws-cdk/cdk');
import { LambdaRestApi } from '@aws-cdk/aws-apigateway';
import { Bucket } from '@aws-cdk/aws-s3';
import { Function, Code, Runtime } from '@aws-cdk/aws-lambda';

export class ThreePercentBackendStack extends cdk.Stack {
    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        const handler = new Function(this, 'Handler', {
            runtime: Runtime.NodeJS810,
            handler: 'index.handler',
            code: Code.asset(path.resolve(path.dirname(__dirname), 'lambda')),
        });
        new LambdaRestApi(this, 'Api', {
            handler,
        });

        new Bucket(this, 'Bucket', {
            bucketName: 'musseulmoton-3percent',
        });
    }
}
