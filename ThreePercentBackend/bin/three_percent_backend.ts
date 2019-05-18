#!/usr/bin/env node
import 'source-map-support/register';
import cdk = require('@aws-cdk/cdk');
import { ThreePercentBackendStack } from '../lib/three_percent_backend-stack';

const app = new cdk.App();
const stack = new ThreePercentBackendStack(app, 'ThreePercentBackendStack');
stack.node.apply(new cdk.Tag('Purpose', '무쓸모톤 10팀'));
