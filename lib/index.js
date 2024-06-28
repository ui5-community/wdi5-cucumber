let { Given, When, Then } = require('@cucumber/cucumber');
let lib = require('wdi5-fe-selectors');

Given('we press tile {string}', async function (name) {
  await lib.pressTile(name);
})