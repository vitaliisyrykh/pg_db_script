const { Client } = require('pg');
const User = require('./User');
const config = require('../configs/db.json');

const client = new Client(config);

User._client = client;

module.exports = {
  client,
  User
};
