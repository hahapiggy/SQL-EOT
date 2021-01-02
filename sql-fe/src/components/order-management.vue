<template>
  <v-container class="fill-height" fluid>
    <v-overlay :value="loading">
      <v-progress-circular size=90 indeterminate></v-progress-circular>
    </v-overlay>
    <v-dialog
      v-model="editing"
      max-width="75%"
    >
      <v-card>
        <v-card-title v-if="editingMode == 'edit'" primary-title>查看訂單 {{editingItem.id}}</v-card-title>
        <v-card-title v-else primary-title>
          新增訂單
          <v-btn small class="ml-2" @click="triggerItemAdd" color="#007000">
            <v-icon>mdi-plus</v-icon>
            新增訂單內容
          </v-btn>
        </v-card-title>
        <v-card-text class="mb-0">
          <v-card-subtitle>訂單內容</v-card-subtitle>
          <v-data-table
            :headers="itemHeaders"
            :items="editingItem.items"
          >
            <template v-slot:item.act="{item}" >
              <!-- <v-btn icon small class="ma-2" @click="triggerItemEdit(item)" color="#00a5f0"> <v-icon>mdi-pencil</v-icon> </v-btn> -->
              <v-btn icon small class="ma-2" @click="triggerItemRemove(item)" color="#f00000"> <v-icon>mdi-trash-can-outline</v-icon> </v-btn>
            </template>
          </v-data-table>
          <v-card-subtitle>訂單備註</v-card-subtitle>
          <v-textarea
            solo
            v-model="editingItem.remarks"
            class="mb-0"
          ></v-textarea>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn v-if="editingMode != 'edit'" class="ma-2 mt-0" @click="editing = false" color="#700000">
            <v-icon>mdi-close</v-icon>
            取消
          </v-btn>
          <v-btn v-if="editingMode == 'edit'" @click="editing = false"  color="#007000">
            <v-icon>mdi-close</v-icon>
            <span>關閉</span>
          </v-btn>
          <v-btn v-else class="ma-2 mt-0" @click="add" color="#007000">
            <v-icon>mdi-check</v-icon>
            <span>送出</span>
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-dialog
      v-model="itemEditing"
      max-width="75%"
    >
      <v-card>
        <v-card-title primary-title>新增菜單項目</v-card-title>
        <v-card-text>
          <v-row>
            <v-col>
              <v-autocomplete 
                label="品項"
                v-model="editingItemOfItem.menu_name"
                :items="menu"
              /> 
            </v-col>
            <v-col> <v-text-field v-model="editingItemOfItem.remarks" label="備註"/> </v-col>
          </v-row>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn class="ma-2" @click="itemEditing = false" color="#700000">
            <v-icon>mdi-close</v-icon>
            取消
          </v-btn>
          <v-btn class="ma-2" @click="addItem" color="#007000">
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
            訂單管理
            <v-btn small class="ml-2" @click="triggerAdd" color="#007000">新增</v-btn>
          </v-card-title>
          <v-card-text>
            <v-data-table
              :headers=headers
              :items=orders
            >
              <template v-slot:item.act="{ item }">
                <v-btn class="ma-2" @click="triggerEdit(item)" color="#004560">
                  <v-icon>mdi-format-list-checkbox</v-icon>
                  查看
                </v-btn>
                <v-btn class="ma-2" @click="triggerRemove(item)" color="#700000">
                  <v-icon>mdi-check</v-icon>
                  完成
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
      editing: false,
      editingMode: "edit",
      itemEditing: false,
      loading: false,
      editingItemOfItem: {}, 
      editingItem: {},
      editingIdx: 0,
      editingItemOfItemIdx: 0,
      headers:[
        {text: "訂單ID", value: "id", align: "center"},
        {text: "訂單類型", value: "order_type", align: "center"},
        {text: "付款方式", value: "payment_method", align: "center"},
        {text: "訂單日期", value: "date", align: "center"},
        {text: "桌號", value: "table_number", align: "center"},
        {text: "總價", value: "price", align: "center"},
        {text: "操作", value: "act", align: "center"},
      ],
      orders:[
        {
          id: "001",
          order_type: "內用",
          payment_method: "現金",
          date: "2020/10/20",
          table_number: "1",
          price: "130",
          items:[
            { id: "003", menu_name: "測試牛肉湯3", price: 522, remarks: "testtest" }, 
            { id: "003", menu_name: "測試牛肉湯2", price: 522, remarks: "testtest" }, 
            { id: "003", menu_name: "測試牛肉湯1", price: 522, remarks: "testtest" }, 
          ],
          remarks: "test test",
        },
        {
          id: "002",
          order_type: "外帶",
          payment_method: "刷卡",
          date: "2020/10/20",
          table_number: "-",
          price: "100",
          items:[
            { id: "003", menu_name: "測試牛肉湯3", price: 522, remarks: "testtest" }, 
            { id: "003", menu_name: "測試牛肉湯1", price: 522, remarks: "testtest" }, 
          ],
          remarks: "test test",
        },
      ],
      menu:[],
    }
  },
  computed: {
    itemHeaders(){
      if(this.editingMode == 'edit'){ 
        return [
          {text: "商品ID", value: "id", width: "12%", align: "center"},
          {text: "商品名稱", value: "menu_name", width: "12%", align: "center"},
          {text: "商品價格", value: "price", width: "12%", align: "center"},
          {text: "備註", value: "remarks", width: "44%", align: "center"},
        ];
      }
      return [
        {text: "商品ID", value: "id", width: "12%", align: "center"},
        {text: "商品名稱", value: "menu_name", width: "12%", align: "center"},
        {text: "商品價格", value: "price", width: "12%", align: "center"},
        {text: "備註", value: "remarks", width: "44%", align: "center"},
        {text: "操作", value: "act", width: "10%", align: "center"},
      ];
    }
  },
  methods: {
    triggerAdd(){
      this.editingItem = {
        id: undefined,
        order_type: undefined,
        payment_method: undefined,
        date: undefined,
        table_number: undefined,
        price: undefined,
        items:[],
        remarks: undefined,
      };
      this.editingMode = "new";
      this.editing = true;
    },
    triggerEdit(item){
      this.editingIdx = this.orders.indexOf(item);
      this.editingMode = "edit";
      Object.assign(this.editingItem, item);
      this.editing = true;
    },
    triggerItemAdd(){
      this.editingItemOfItem = {};
      this.itemEditing = true;
    },
    triggerItemRemove(item){
      console.log(item);
      console.log(this.orders[this.editingIdx]);
      this.editingItemOfItemIdx = this.editingItem.items.indexOf(item);
      console.log(this.editingItemOfItemIdx);
      this.editingItem.items.splice(this.editingItemOfItemIdx, 1);
    },
    triggerRemove(item){
      this.editingIdx = this.orders.indexOf(item);
      this.orders.splice(this.editingIdx, 1);
      this.$toast.success(`訂單已完成！`);
      // Object.assign(this.editingItem, item);
      // this.removing = true;
    },
    addItem(){
      console.log(this.editingItemOfItem);
      let clone = new Object();
      Object.assign(clone, this.editingItemOfItem);
      this.editingItem.items.push(clone);
      this.itemEditing = false;
    },
    add(){
      this.loading = true;
      let clone = new Object();
      Object.assign(clone, this.editingItem);
      this.orders.push(clone);
      // DO AXIOS THINGS
      this.editing = false;
      this.loading = false;
      this.$toast.success(`已成功新增訂單！`);
      Object.assign(this.editingItem, {});
    },
    edit(){
      this.loading = true;
      this.orders[this.editingIdx].menu_name = this.editingItem.menu_name
      this.orders[this.editingIdx].price = this.editingItem.price
      // DO AXIOS THINGS
      this.editing = false;
      this.loading = false;
      this.$toast.success(`已成功編輯商品！${this.editingItem.menu_name}`);
      Object.assign(this.editingItem, {});
    },
    remove(){
      this.loading = true;
      this.orders.splice(this.editingIdx, 1);
      // DO AXIOS THINGS
      this.removing = false;
      this.loading = false;
      this.$toast.error(`已成功刪除商品！${this.editingItem.menu_name}`);
      Object.assign(this.editingItem, {});
    },
  },
}
// - GOTTA SAY THIS CODE IS SOOOO DIRTY, BUT I AM 2 LAZY 2 MAKE IT LEGIT
</script>
