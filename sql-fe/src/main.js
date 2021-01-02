import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import axios from './plugins/axios';
import toastification from './plugins/vue-toastification';
import router from './router'


Vue.config.productionTip = false

new Vue({
  vuetify,
  toastification,
  axios,
  router,
  render: h => h(App)
}).$mount('#app')
