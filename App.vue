<script setup>
import { ref } from 'vue'
import axios from 'axios'

const city = ref('')
const weather = ref(null)
const error = ref('')

const getWeather = async () => {
  error.value = ''
  try {
    const response = await axios.get(`http://localhost:3000/api/weather`, {
      params: { city: city.value }
    })
    weather.value = response.data
  } catch (e) {
    error.value = 'Nem sikerült lekérni az adatokat.'
  }
}
</script>

<template>
  <div>
    <input v-model="city" placeholder="Város neve">
    <button @click="getWeather">Lekérés</button>
    <div v-if="weather">
      <h3>{{ weather.name }}</h3>
      <p>Hőmérséklet: {{ weather.main.temp }} °C</p>
      <p>Leírás: {{ weather.weather[0].description }}</p>
    </div>
    <div v-if="error">{{ error }}</div>
  </div>
</template>
