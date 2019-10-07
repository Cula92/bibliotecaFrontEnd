<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>

<head>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/vue@2.6.0"></script>
<script
	src="https://cdn.jsdelivr.net/npm/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.13.1/lodash.min.js"></script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Inserisci testo</title>

</head>
<body background="resources/img/wall.jpg">

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<!-- Brand -->
		<a class="navbar-brand" href="home">Biblioteca Fiamma</a>

		<!-- Links -->
		<ul class="navbar-nav">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbardrop"
				data-toggle="dropdown"> Gestione Testi </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="InserisciGenere">Inserisci nuovo
						genere</a> <a class="dropdown-item" href="InserisciTesto">Inserisci
						nuovo testo</a> <a class="dropdown-item" href="ElencoTesti">Elenco
						testi</a>
				</div></li>
			<!-- Dropdown -->
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbardrop"
				data-toggle="dropdown"> Gestione Soci </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="InserisciSocio">Aggiungi socio</a> <a
						class="dropdown-item" href="ElencoSoci">Elenco soci</a> <a
						class="dropdown-item" href="RestituzioneTesti">Restituzione
						testi</a>
				</div></li>
		</ul>
	</nav>

	<div id="app">
		<div class="container" style="padding: 2%">
			<div class="row justify-content-center">
				<div class="col-md-8">
					<div class="card">
						<div class="card-header">Inserimento nuovo testo</div>

						<div class="card-body">

							<form @submit="formSubmit">

								<strong>Codice_ISBN:</strong> <input class="form-control"
									v-model="codice_ISBN" required="required"><br> <strong>Tipo:</strong>
								<select v-model="tipo" class="form-control">
									<option value="L">Libro</option>
									<option value="R">Rivista</option>
								</select><br> <strong>Titolo:</strong> <input class="form-control"
									v-model="titolo" required="required"><br> <strong>Editore:</strong>
								<input class="form-control" v-model="editore"
									required="required"><br> <strong>Genere:</strong>
								<select v-model="genere" class="form-control">
									<option value="" selected disabled hidden>Seleziona
										genere</option>
									<option v-for="i in info" v-bind:value="i">{{
										i.descrizione }}</option>
								</select><br> <strong>Data Acquisizione:</strong> <input type="date"
									class="form-control" v-model="data_Acquisizione" disabled
									required="required"><br> <strong>Data
									Pubblicazione:</strong> <input type="date" class="form-control"
									v-model="data_Pubblicazione" required="required"><br>

								<span v-if="tipo === 'L'"> <strong>Autore:</strong> <input
									class="form-control" v-model="autore"><br> <strong>Collana:</strong>
									<input class="form-control" v-model="collana"><br>

								</span>

								<button class="btn btn-success">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://unpkg.com/vue-toasted"></script>

	<script>
    Vue.use(Toasted)
    
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
              output: null,
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
                    currentObj.toast(currentObj.output.messaggio, currentObj.output.tipoMessaggio);
                    if(currentObj.output.tipoMessaggio == 'success'){
                    	currentObj.codice_ISBN = '';
                    	currentObj.tipo = '';
                    	currentObj.titolo = '';
                    	currentObj.editore = '';
                    	currentObj.genere = 0;
                    	currentObj.data_Pubblicazione = '';
                    	currentObj.autore = '';
                    	currentObj.collana = '';
                    }               	
                })
                .catch(function (error) {
                    currentObj.output = error;
                });
            },
            toast(text, toastType){
            	this.$toasted.show("<h2>" + text +  "</h2>", { 
           		 theme: "toasted-primary", 
           		 position: "top-right", 
           		 duration : 3000,
           		 type : toastType
           	});
            },
        }
	})
</script>

</body>
</html>