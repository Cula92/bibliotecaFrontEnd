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

<title>Elenco soci</title>

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
						<div class="card-header">Ricerca</div>

						<div class="card-body">

							<form @submit="formSubmit">
								<strong>Selezionare un numero tessera per conoscerne i
									dettagli</strong><select v-model="socio" class="form-control">
									<option value="" selected disabled hidden>Seleziona un
										numero tessera</option>
									<option v-for="i in info" v-bind:value="i">{{
										i.numero_Tessera }}</option>
								</select><br>

								<button class="btn btn-success">Cerca</button>
							</form>

							<div v-if="flagRicerca">

								<strong>Numero tessera:</strong> <input class="form-control"
									v-model="numero_Tessera" required="required" disabled><br>

								<strong>Nome:</strong> <input class="form-control"
									v-model="nome" required="required"><br>

								<!-- <strong>Cognome:</strong>
                        <input class="form-control" v-model="cognome" required="required"><br> -->

								<strong>Codice Fiscale:</strong> <input class="form-control"
									v-model="codice_Fiscale" required="required"><br>
								<strong>Telefono:</strong> <input class="form-control"
									v-model="telefono" required="required"><br> <strong>Genere
									preferito:</strong> <select v-model="genere" class="form-control">
									<!--  <option v-if="infoRicerca != null" v-bind:value="genere_Preferito.codice_genere" selected hidden>{{genere_Preferito.descrizione}}</option>-->
									<option selected disabled hidden>Seleziona genere</option>
									<option v-for="i in infoGeneri" v-bind:value="i">{{
										i.descrizione }}</option>
								</select><br> <strong>Data Iscrizione:</strong> <input type="date"
									class="form-control" v-model="data_Iscrizione" disabled
									required="required"><br> <strong>Numero
									testi in prestito:</strong> <input class="form-control"
									v-model="testi_Prestito" required="required" disabled><br>

								<button class="btn btn-success" @click="aggiornaSocio">Salva</button>
								<button class="btn btn-success" @click="eliminaSocio">Elimina</button>
							</div>


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
              info: null,
              infoGeneri: null,
              infoRicerca: null,
              flagRicerca: false,
              dato: null,
              socio: '',
              testi_Prestito: '',
              nome: '',
              telefono: '',
              genere: '',
              data_Iscrizione: '',
              codice_Fiscale: '',
              numero_Tessera: '',
              output: ''
            };
        },
        mounted () {
        	{
  			  axios
  		      .get('http://localhost:8080/biblioFE/getSoci')
  		      .then(response => (this.info = response.data))	
  	  		}
        },
        created (){
        	{
        	   axios
   		      .get('http://localhost:8080/biblioFE/getGeneri')
   		      .then(response => (this.infoGeneri = response.data))	
        	}
        	
        },
  	  	methods: {
            formSubmit(e) {
                e.preventDefault();
                let currentObj = this;
                this.flagRicerca = true;
                axios.post('http://localhost:8080/biblioFE/getSocio', {
                    parametroNumerico: this.socio.numero_Tessera
                })
                .then(function (response) {
                	currentObj.infoRicerca = response.data;
                	currentObj.codice_Fiscale = response.data.codice_Fiscale;
                	currentObj.nome = response.data.nome_Cognome;
                	currentObj.genere = response.data.genere;
                	currentObj.data_Iscrizione = response.data.data_Iscrizione;
                	currentObj.telefono = response.data.telefono;
                	currentObj.numero_Tessera = response.data.numero_Tessera;
                	currentObj.testi_Prestito = response.data.testi_Prestito;
                })
            },
            aggiornaSocio(){
            	let currentObj = this;
            	axios.post('http://localhost:8080/biblioFE/updateSocio', {
            		numero_Tessera: this.numero_Tessera,
                    nome: this.nome,
                    cognome: '',
                    codice_Fiscale: this.codice_Fiscale,
                    telefono: this.telefono,
                    codice_genere: this.genere.codice_genere,
                    data_Iscrizione: this.data_Iscrizione,
                    
                })
                .then(function (response) {
                    currentObj.output = response.data;
                    currentObj.toast(currentObj.output.messaggio, currentObj.output.tipoMessaggio);
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
            eliminaSocio(){
            	let currentObj = this;
            	axios.post('http://localhost:8080/biblioFE/deleteSocio', {
            		numero_Tessera: this.numero_Tessera,
                    nome: this.nome,
                    cognome: '',
                    codice_Fiscale: this.codice_Fiscale,
                    telefono: this.telefono,
                    codice_genere: this.genere.codice_genere,
                    data_Iscrizione: this.data_Iscrizione,
                    
                })
                .then(function (response) {
                    currentObj.output = response.data;
                    currentObj.toast(currentObj.output.messaggio, currentObj.output.tipoMessaggio);
                    if(currentObj.output.tipoMessaggio == 'success'){
                    	currentObj.flagRicerca = false;
                    	currentObj.socio = '';
                    	   axios
            		      .get('http://localhost:8080/biblioFE/getSoci')
            		      .then(function (response) {
            		    	  currentObj.info = response.data;
            		      });
                    }
                })
                .catch(function (error) {
                    currentObj.output = error;
                });
            }
        }
	})
</script>

</body>


</html>