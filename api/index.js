const axios = require('axios');

const http = axios.create({
  baseURL: 'https://randomuser.me/api/'
});

module.exports.loadUsers = async () => {
  const {
    data: { results }
  } = await http.get('?results=100&seed=abcderr&page=1');

  return results;
};
