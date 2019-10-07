<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <script src="https://cdn.jsdelivr.net/npm/vue@2.6.0"></script>
		<script src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/lodash@4.13.1/lodash.min.js"></script>
    </head>

    <body>   
    
    <div id="app">
	  		<select v-model="selected"  >
	  		<option value="" selected disabled hidden>Seleziona genere</option>
		  		<option v-for="i in info" v-bind:value="i">
	    			{{ i.descrizione }}
	  			</option>
  			</select>
  			<button @click="deleteFun()">Delete</button>
	</div> 
		<script>	

		new Vue({
			  el: '#app',
			  data () {
				  return{
					  selected: '',
			      	  info: null
				  }
			  },
			  mounted () {
				  	{
					  axios
				      .get('http://localhost:8080/biblioFE/getGeneri')
				      .then(response => (this.info = response.data))			  
			  		}	    
			  	},
			  methods:{
				  deleteFun(){
					  axios.post('http://localhost:8080/biblioBE/genere/eliminateGenere', {
		                    codice_genere: this.selected.codice_genere, descrizione: ''
		                })
		                .catch(error => {
					        console.log(error)
					        this.errored = true
					      })
					    .finally(() => this.loading = false);
					  this.info.splice(this.info.indexOf(this.selected), 1);
				  }
				  
				  
				 
			  }
  
			})
		</script>
    </body>
</html>