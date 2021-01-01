import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import axios from './plugins/axios';
import toastification from './plugins/vue-toastification';


Vue.config.productionTip = false

new Vue({
  vuetify,
  toastification,
  axios,
  render: h => h(App)
}).$mount('#app')
