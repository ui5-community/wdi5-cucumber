const path = require('node:path')

exports.config = {
    specs: [
        '../../../test/features/test.feature',
    ],
    exclude: [
    ],
    maxInstances: 10,
    capabilities: [
        {
            maxInstances: 5,
            //
            browserName: 'chrome',
            "goog:chromeOptions": {
                args:
                    process.argv.indexOf("--headless") > -1
                        ? ["--headless=new"]
                        : process.argv.indexOf("--debug") > -1
                            ? ["window-size=1440,800", "--auto-open-devtools-for-tabs"]
                            : ["window-size=1440,800"]
            },
            acceptInsecureCerts: true
        }
    ],
    logLevel: 'error',
    bail: 0,
    baseUrl: 'http://localhost:8080/index.html',
    waitforTimeout: 10000,
    connectionRetryTimeout: process.argv.indexOf('--debug') > -1 ? 1200000 : 120000,
    connectionRetryCount: 3,
    services: ['ui5'],
    framework: 'cucumber',
    cucumberOpts: {
        require: ['../node_modules/wdi5-cucumber/lib/index.js'],
        tagExpression: '',
    },
    reporters: ['spec'],
}
