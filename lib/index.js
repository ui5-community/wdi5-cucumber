const { Given, When, Then } = require('@cucumber/cucumber');
let lib = require('wdi5-fe-selectors');

Given('we press tile {string}', async (name) => {
  await lib.pressTile(name);
})
