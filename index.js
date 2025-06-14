require('dotenv').config();  // 👈 Loads .env

const express = require('express');
const app = express();

const port = process.env.PORT || 3000;
const greeting = process.env.GREETING || 'Hello World!';

app.get('/', (req, res) => res.send(greeting));
app.get('/health', (req, res) => res.send('OK'));

app.listen(port, () => console.log(`Server running on port 3000`));
