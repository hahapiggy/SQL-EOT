<template>
  <v-container class="fill-height" fluid> 
    <v-card >
      <v-card-title class="white--text">
        抱歉冠傑牛肉湯訂單管理系統
      </v-card-title>
      <v-card-text>
        <v-row justify="center" align="center">
          <v-col cols=6>
            <v-card height="100%" width="100%">
              <v-img
                class="white--text align-end hover"
                max-height="82vh"
                min-height="82vh"
                gradient="to bottom, rgba(0,0,0, 0), rgba(0,0,0,.1), rgba(0,0,0,.5)"
                src="@/assets/beefsoup.jpg"
                @click="$router.push('/menu-management')"
              >
                <v-card-title class="headline">菜單管理</v-card-title>
                <v-card-subtitle>Menu management</v-card-subtitle>
              </v-img>
            </v-card>
          </v-col>
          <v-col cols=6>
            <v-card height="100%" width="100%">
              <v-img
                class="white--text align-end hover"
                max-height="82vh"
                min-height="82vh"
                gradient="to bottom, rgba(0,0,0, 0), rgba(0,0,0,.1), rgba(0,0,0,.5)"
                src="@/assets/order.jpg"
                @click="$router.push('/order-management')"
              >
                <v-card-title class="headline">訂單管理</v-card-title>
                <v-card-subtitle>Order management</v-card-subtitle>
              </v-img>
            </v-card>
          </v-col>
        </v-row>  
      </v-card-text>  
    </v-card>
  </v-container>
</template>

<script>
export default {
  
}
</script>

<style scoped>
.hover{
  transition: 0.6s;
}
.hover:hover {
  cursor: pointer !important;
  filter: brightness(1.5);
  transition: 0.6s;
}
</style>