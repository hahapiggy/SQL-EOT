<template>
  <v-container class="fill-height" fluid>
    <v-overlay :value="loading">
      <v-progress-circular size=90 indeterminate></v-progress-circular>
    </v-overlay>
    <v-dialog
      v-model="editing"
      max-width="55%"
    >
      <v-card>
        <v-card-title primary-title>編輯菜單項目</v-card-title>
        <v-card-text>
          <v-row>
            <v-col> <v-text-field v-model="editingItem.id" label="商品ID" disabled/> </v-col>
            <v-col> <v-text-field v-model="editingItem.menu_name" label="商品名稱" /> </v-col>
            <v-col> <v-text-field v-model="editingItem.price" label="商品價格" /> </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn class="ma-2" @click="editing = false" color="#700000">
            <v-icon>mdi-close</v-icon>
            取消
          </v-btn>
          <v-btn class="ma-2" @click="edit" color="#007000">
            <v-icon>mdi-check</v-icon>
            確認
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="removing"
      max-width="55%"
    >
      <v-card>
        <v-card-title primary-title>刪除菜單項目</v-card-title>
        <v-card-subtitle primary-title>請確認刪除菜單項目</v-card-subtitle>
        <v-card-text>
          <v-row>
            <v-col> <v-text-field v-model="editingItem.id" label="商品ID" disabled/> </v-col>
            <v-col> <v-text-field v-model="editingItem.menu_name" label="商品名稱" disabled/> </v-col>
            <v-col> <v-text-field v-model="editingItem.price" label="商品價格" disabled/> </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn class="ma-2" @click="removing = false" color="#700000">
            <v-icon>mdi-close</v-icon>
            取消
          </v-btn>
          <v-btn class="ma-2" @click="remove" color="#007000">
            <v-icon>mdi-trash-can-outline</v-icon>
            確認刪除
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="newing"
      max-width="55%"
    >
      <v-card>
        <v-card-title primary-title>新增菜單項目</v-card-title>
        <v-card-text>
          <v-row>
            <v-col> <v-text-field label="商品ID (此欄位由系統自動產生)" disabled/> </v-col>
            <v-col> <v-text-field v-model="editingItem.menu_name" label="商品名稱"/> </v-col>
            <v-col> <v-text-field v-model="editingItem.price" label="商品價格"/> </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn class="ma-2" @click="newing = false" color="#700000">
            <v-icon>mdi-close</v-icon>
            取消
          </v-btn>
          <v-btn class="ma-2" @click="add" color="#007000">
            <v-icon>mdi-check</v-icon>
            送出
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-card
      class="mx-auto"
      elevation="3"
      min-width="90%"
      max-width="90%"
      min-height="90%"
      max-height="90%"
    >
      <v-card-title class="white--text">
        抱歉冠傑牛肉湯訂單管理系統
        <v-spacer />
        <v-btn 
          outlined
          small
          @click="$router.push('/')"
        >
          <v-icon>mdi-undo-variant</v-icon>
          返回主頁
        </v-btn>
      </v-card-title>
      <v-card-text>
        <v-card>
          <v-card-title class="white--text">
            菜單管理
            <v-btn small class="ml-2" @click="triggerAdd" color="#007000">新增</v-btn>
          </v-card-title>
          <v-card-text>
            <v-data-table
              :headers=headers
              :items=menu
            >
              <template v-slot:item.act="{ item }">
                <v-btn class="ma-2" @click="triggerEdit(item)" color="#004560">
                  <v-icon>mdi-pencil</v-icon>
                  編輯
                </v-btn>
                <v-btn class="ma-2" @click="triggerRemove(item)" color="#700000">
                  <v-icon>mdi-trash-can-outline</v-icon>
                  刪除
                </v-btn>
              </template>
            </v-data-table>
          </v-card-text>
        </v-card>
      </v-card-text>  
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      newing: false,
      editing: false,
      removing: false,
      loading: false,
      editingItem:{
        iD: undefined,
        name: undefined,
        price: undefined,
      },
      editingIdx: 0,
      headers:[
        {text: "商品ID", value: "id", width: "15%", align: "center"},
        {text: "商品名稱", value: "menu_name", width: "25%", align: "center"},
        {text: "商品價格", value: "price", width: "25%", align: "center"},
        {text: "操作", value: "act", width: "25%", align: "center"},
      ],
      menu:[
        { id: "001", menu_name: "測試牛肉湯", price: 5 },
        { id: "002", menu_name: "測試牛肉湯2", price: 52 },
        { id: "003", menu_name: "測試牛肉湯3", price: 522 },
      ]
    }
  },
  methods: {
    triggerAdd(){
      this.editingItem = {};
      this.newing = true;
    },
    triggerEdit(item){
      this.editingIdx = this.menu.indexOf(item);
      Object.assign(this.editingItem, item);
      this.editing = true;
    },
    triggerRemove(item){
      this.editingIdx = this.menu.indexOf(item);
      Object.assign(this.editingItem, item);
      this.removing = true;
    },
    add(){
      this.loading = true;
      this.menu.push(this.editingItem);
      this.newing = false;
      // DO AXIOS THINGS
      this.loading = false;
      this.$toast.success(`已成功新增商品！${this.editingItem.menu_name}`);
      Object.assign(this.editingItem, {});
    },
    edit(){
      this.loading = true;
      this.menu[this.editingIdx].menu_name = this.editingItem.menu_name
      this.menu[this.editingIdx].price = this.editingItem.price
      this.editing = false;
      // DO AXIOS THINGS
      this.loading = false;
      this.$toast.success(`已成功編輯商品！${this.editingItem.menu_name}`);
      Object.assign(this.editingItem, {});
    },
    remove(){
      this.loading = true;
      this.menu.splice(this.editingIdx, 1);
      this.removing = false;
      // DO AXIOS THINGS
      this.loading = false;
      this.$toast.error(`已成功刪除商品！${this.editingItem.menu_name}`);
      Object.assign(this.editingItem, {});
    },
  },
}
// - GOTTA SAY THIS CODE IS SOOOO DIRTY, BUT I AM 2 LAZY 2 MAKE IT LEGIT
</script>
