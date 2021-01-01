import Vue from 'vue'
import VueRouter from 'vue-router'
import home from '../components/home'
import menu from '../components/menu-management'
import order from '../components/order-management'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: home
  },
  {
    path: '/menu-management',
    name: 'menu-management',
    component: menu
  },
  {
    path: '/order-management',
    name: 'order-management',
    component: order
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
