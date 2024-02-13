import { ref } from "vue/dist/vue.esm-bundler.js"

export default {
  data() {
    return {
      message: 'Hello!',
      insertText: '',
      project: 'Hello Projects'
    }
  },

  methods: {
    insertMessage(){
      return this.message = this.insertText;
    }
  }
}
