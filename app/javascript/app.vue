<template>
  <div id="app">
    <div class="uk-section">
      <div class="uk-container">
        <div>
          <label for="expr">
            Query Expression
          </label>
          <input
            id="expr"
            v-model="expr"
            class="uk-input"
            type="text"
          >
        </div>
        <div>
          <label for="nums">
            Number of returned papers
          </label>
          <input
            id="nums"
            v-model="nums"
            class="uk-input"
            type="number"
          >
        </div>
        <div>
          <label for="is-top-referenced">
            Whether to return top referenced papers?
          </label>
          <input
            id="is-top-referenced"
            v-model="is_top_referenced"
            class="uk-checkbox"
            type="checkbox"
          >
        </div>
        <div>
          <button
            class="uk-button uk-button-primary uk-width-1-1"
            @click="search"
          >
            Search
          </button>
        </div>
      </div>
    </div>
    <div class="uk-container">
      <table class="uk-table uk-table-small uk-table-hover uk-table-striped">
        <thead>
          <tr>
            <th>Title</th>
            <th>Conference</th>
            <th>Journal</th>
            <th>Year</th>
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
label {
  font-size: 20px;
  text-align: center;
}
</style>
