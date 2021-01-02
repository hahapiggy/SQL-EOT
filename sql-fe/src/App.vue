<template>
  <v-app>
    <transition name="fade">
      <router-view/>
    </transition>
  </v-app>
</template>

<script>

export default {
  name: 'App',

  methods: {
    async apiTest(){
      const res = await this.$axios.get(
        `http://192.168.100.161:8022/api/test.php`,
      );
      console.log(res);
      this.$toast(res.data);
    }
  },

  mounted() {
    this.$toast("SUCCESS!")
    this.apiTest()
  },
};
</script>
