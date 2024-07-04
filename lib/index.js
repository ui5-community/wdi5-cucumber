const { Given, When, Then } = require("@wdio/cucumber-framework")
let lib = require('wdi5-fe-selectors');

Given('we press tile {string}', async (name) => {
  await lib.pressTile(name);
})
