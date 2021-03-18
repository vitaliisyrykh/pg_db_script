const { Client } = require('pg');
const User = require('./User');

const config = {
  user: 'postgres',
  password: 'postgres',
  host: 'localhost',
  port: 5432,
  database: 'fe_test'
};

const client = new Client(config);

User._client = client;

module.exports = {
  client,
  User
};
