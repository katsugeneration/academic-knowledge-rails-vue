<template>
  <div id="app">
    <input
      v-model="expr"
      type="text"
    >
    <button @click="search">
      Search
    </button>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Link</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="paper in papers"
          :key="paper.Id"
        >
          <td>
            {{ paper.Id }}
          </td>
          <td>
            <a
              :href='"https://academic.microsoft.com/paper/" + paper.Id + "/reference/search"'
              target="_blank"
            >goto</a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
const axios = require('axios')

export default {
  data: function () {
    return {
      expr: '',
      papers: null
    }
  },
  methods: {
    search: function () {
      axios.get('/academic_search', {
        params: {
          expr: this.expr
        }
      })
        .then(response => {
          console.log(response.data.entities)
          this.papers = response.data.entities
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
