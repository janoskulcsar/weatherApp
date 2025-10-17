const express = require("express");
const axios = require("axios");
const cors = require("cors");
const app = express();

app.use(cors());

const API_KEY = "0e86d785a93bc6e3b4fa6e30ce0255ee";

app.get("/api/weather", async (req, res) => {
  const city = req.query.city;
  if (!city) return res.status(400).json({ error: "Missing city parameter" });

  const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${API_KEY}`;
  try {
    const response = await axios.get(url);
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(3000, () => console.log("Szerver fut a 3000-es porton"));

