new Vue({
	  el: '#app',
      data() {
          return {
         	  codice_ISBN: '',
         	  tipo: '',
         	  titolo: '',
         	  editore: '',
         	  genere: '',
         	  data_Pubblicazione: '',
         	  data_Acquisizione: new Date().toJSON().slice(0,10).replace(/-/g,'-'),
            autore: '',
            collana: '',
            flag_prestito: 0,
            output: '',
            info: null,
          };
      },
      mounted () {
		  	{
			  axios
		      .get('http://localhost:8080/biblioFE/getGeneri')
		      .then(response => (this.info = response.data))	
	  		}	    
	  	},
      methods: {
          formSubmit(e) {
              e.preventDefault();
              let currentObj = this;
              axios.post('http://localhost:8080/biblioFE/SaveTesto', {
              	codice_ISBN: this.codice_ISBN,
              	tipo: this.tipo,
              	titolo: this.titolo,
              	editore: this.editore,
              	codice_genere: this.genere.codice_genere,
              	data_Pubblicazione: this.data_Pubblicazione,
              	data_Acquisizione: this.data_Acquisizione,
              	flag_prestito: this.flag_prestito,
              	autore: this.autore,
              	collana: this.collana
              })
              .then(function (response) {
                  currentObj.output = response.data;
                  if(currentObj.output === 0)
                  	alert("Testo inserito con successo!");
                  else if(currentObj.output < 0)
                  	alert("Testo già presente!");
              })
              .catch(function (error) {
                  currentObj.output = error;
              });
          }
      }
	})