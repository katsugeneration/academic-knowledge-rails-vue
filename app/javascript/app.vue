<template>
  <div id="app">
    <input
      v-model="expr"
      type="text"
    >
    <input
      v-model="nums"
      type="number"
    >
    <input
      v-model="is_top_referenced"
      type="checkbox"
      />
    <button @click="search">
      Search
    </button>
    <table>
      <thead>
        <tr>
          <th>Title</th>
          <th>Conference</th>
          <th>Journal</th>
          <th>Published Year</th>
          <th>Cited</th>
          <th>Link</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="paper in papers"
          :key="paper.Id"
        >
          <td>
            {{ paper.DN }}
          </td>
          <td>
            {{ ('C' in paper) ? paper.C.CN : '' }}
          </td>
          <td>
            {{ ('J' in paper) ? paper.J.JN : '' }}
          </td>
          <td>
            {{ paper.Y }}
          </td>
          <td>
            {{ paper.CC }}
          </td>
          <td>
            <a
              :href="'https://academic.microsoft.com/paper/' + paper.Id + '/reference/search'"
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
      nums: 10,
      is_top_referenced: false,
      papers: null
    }
  },
  methods: {
    search: function () {
      axios.get('/academic_search', {
        params: {
          expr: this.expr,
          nums: this.nums,
          is_top_referenced: this.is_top_referenced
        }
      })
        .then(response => {
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
