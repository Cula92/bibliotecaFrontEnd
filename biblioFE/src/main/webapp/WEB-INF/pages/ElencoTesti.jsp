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

<title>Elenco testi</title>


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

							<strong>Quali criteri di ricerca vuoi utilizzare?</strong> <br>

							<select v-model="tipoRicerca" class="form-control">
								<option value="1">Ricerca per Autore e/o Titolo</option>
								<option value="2">Ricerca per Codice e/o Editore</option>
								<option value="3">Mostra tutti i testi</option>
							</select><br> <br>

							<div v-if="flagPrestito">

								<strong>Prestito:</strong> <br> <strong>Codice
									ISBN:</strong> <input class="form-control"
									v-model="testoSelezionato.codice_ISBN" required="required"
									disabled> <strong>Socio:</strong> <br> <select
									v-model="socio" class="form-control">

									<option selected disabled hidden>Seleziona socio</option>
									<option v-for="i in infoSoci" v-bind:value="i">
										{{i.nome_Cognome }} (Numero Tessera:{{i.numero_Tessera}})</option>
								</select><br>

								<button class="btn btn-success" @click="effettuaPrestito(socio)">Effettua
									Prestito</button>
								<!-- Warning message -->



							</div>


							<div v-if="flagTipoRicerca">
								<form @submit="formSubmitAT" v-if="flagAutoreTitolo">

									<strong>Ricerca per Autore e/o Titolo:</strong><br> <br>
									<strong>Autore:</strong> <input class="form-control"
										v-model="parametroRicerca"><br> <strong>Titolo:</strong>
									<input class="form-control" v-model="parametroRicerca1"><br>

									<button class="btn btn-success">Cerca</button>
								</form>

								<form @submit="formSubmitC" v-if="flagCodice">

									<strong>Ricerca per Codice e/o Editore:</strong><br> <br>
									<strong>Codice:</strong> <input class="form-control"
										v-model="parametroRicerca"><br> <strong>Editore:</strong>
									<input class="form-control" v-model="parametroRicerca1"><br>

									<button class="btn btn-success">Cerca</button>
								</form>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>

		<br>

		<div v-if="flagRicerca" style="padding-left: 5%; padding-right: 5%">

			<table class="table table-hover table-dark">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Codice ISBN</th>
						<th scope="col">Tipo</th>
						<th scope="col">Titolo</th>
						<th scope="col">Editore</th>
						<th scope="col">Genere</th>
						<th scope="col">Data pubblicazione</th>
						<th scope="col">Data acquisizione</th>
						<th scope="col">Autore</th>
						<th scope="col">Collana</th>
					</tr>
				</thead>
				<tr v-for="i in info">
					<td><a v-if="i.flag_Prestito == 0" href="#"
						@click="eliminaTesto(i.codice_ISBN)"><img
							src="resources/img/delete.png" width="30px" height="30px"
							title="Elimina"></img></a> <a v-if="i.flag_Prestito == 0" href="#"
						@click="prestaTesto(i)"><img src="resources/img/prestito.png"
							width="30px" height="30px" title="Prestito"></img></a> <!-- <a href="#" @click="prestaTesto(i)"><img></img></a> -->
					</td>
					<td>{{i.codice_ISBN}}</td>
					<td v-if="i.tipo === 'L'">Libro</td>
					<td v-else>Rivista</td>
					<td>{{i.titolo}}</td>
					<td>{{i.editore}}</td>
					<td>{{i.genere.descrizione}}</td>
					<td>{{i.data_Pubblicazione}}</td>
					<td>{{i.data_Acquisizione}}</td>
					<td v-if="i.libro">{{i.libro.autore}}</td>
					<td v-else></td>
					<td v-if="i.libro">{{i.libro.collana}}</td>
					<td v-else></td>
				</tr>
			</table>
		</div>
	</div>

	<script src="https://unpkg.com/vue-toasted"></script>

	<script>
    	Vue.use(Toasted)
	</script>

	<script>

new Vue({
	  el: '#app',
        data() {
            return {
              info: null,
              infoElim: null,
              infoSoci: null,
              infoPrestito: null,
              parametroRicerca: '',
              parametroRicerca1: '',
              flagPrestito: false,
              flagRicerca: false,
              flagTipoRicerca: false,
              flagAutoreTitolo: false,
              flagCodice: false,
              flagToastRicerca: false,
              testoSelezionato: null,
              socio: null,
              modalFlag: false,
              messaggio: '',
              tipoRicerca: 0,
              dato: null
            };
        },
        methods: {
            formSubmitAT(e) {
                e.preventDefault();
                let currentObj = this;
                axios.post('http://localhost:8080/biblioFE/getTestiByAutoreTitolo', {
                	parametroRicerca: currentObj.parametroRicerca,
                	parametroRicerca1: currentObj.parametroRicerca1
                	})
                .then(function (response) {
                	currentObj.info = null;
                	currentObj.info = response.data;
                	if(currentObj.info != null && currentObj.info != '')
                		currentObj.flagRicerca = true;
                	else{
                        currentObj.toast('Nessun risultato', 'error'); 	
                        currentObj.flagRicerca = false;
                	}
                })    
            }, 
                formSubmitC(e) { 
                    e.preventDefault();
                    let currentObj = this;
                    axios.post('http://localhost:8080/biblioFE/getTestiByCodiceEditore', {
                    	parametroRicerca: currentObj.parametroRicerca,
                    	parametroRicerca1: currentObj.parametroRicerca1
                    })
                    .then(function (response) { 
                    	currentObj.info = null;
                    	currentObj.info = response.data;
                    	if(currentObj.info != null && currentObj.info != '')
                    		currentObj.flagRicerca = true;
                    	else{
                            currentObj.toast('Nessun risultato', 'error'); 	
                            currentObj.flagRicerca = false;
                    	}
                    })    
                },
                eliminaTesto(codice_isbn){
                	let currentObj = this;
                	axios.post('http://localhost:8080/biblioFE/deleteTesto', {parametroRicerca: codice_isbn})
                    .then(function (response) {
                        currentObj.infoElim = response.data;
                        if(currentObj.infoElim){
                        	currentObj.toast('Testo eliminato con successo', 'success');
                            axios.get('http://localhost:8080/biblioFE/getTestiDisponibili')
                            .then(function (response) {
                                currentObj.info = response.data;})
                        }
                        else{
                        	currentObj.toast('Eliminazione fallita!', 'error');
                        }
                    })
                },
                effettuaPrestito(socio){
                	let currentObj = this;
                	axios.post('http://localhost:8080/biblioFE/SavePrestito', {
                		parametroRicerca: this.testoSelezionato.codice_ISBN,
                		parametroNumerico: socio.numero_Tessera
                		})
                    .then(function (response) {
                        currentObj.infoPrestito = response.data;
                        currentObj.toast(currentObj.infoPrestito.messaggio, currentObj.infoPrestito.tipoMessaggio);
                        if(currentObj.infoPrestito.tipoMessaggio == 'success'){
                        	axios.get('http://localhost:8080/biblioFE/getTestiDisponibili')
                            .then(function (response) {
                                currentObj.info = response.data;})
                        }
                    })
                },
                prestaTesto(i){
                	this.flagPrestito = true;
                	this.flagAutoreTitolo = false;
                	this.falagCodice = false;
                	this.testoSelezionato = i;
                	let currentObj = this;
                	axios.get('http://localhost:8080/biblioFE/getSoci')
                    .then(function (response) {
                        currentObj.infoSoci = response.data;
                    })
                    .catch(function (error) {
                        currentObj.infoSoci = error; 
                    });
                	
                },
                toast(text, toastType){
                	this.$toasted.show("<h2>" + text +  "</h2>", { 
               		 theme: "toasted-primary", 
               		 position: "top-right", 
               		 duration : 3000,
               		 type : toastType
               	});
                }
        },
        watch: {
        	tipoRicerca: function() {
        		this.info = null;
                this.flagTipoRicerca = true;
                if(this.tipoRicerca == 1)
                	{this.flagAutoreTitolo = true; this.flagCodice = false; this.flagRicerca = false;this.flagPrestito = false;}
                else if(this.tipoRicerca == 2)
                {this.flagAutoreTitolo = false; this.flagCodice = true; this.flagRicerca = false;this.flagPrestito = false;}
                else if(this.tipoRicerca == 3){
                	axios.get('http://localhost:8080/biblioFE/getTestiDisponibili')
                    .then(response => (this.info = response.data))
                    this.flagRicerca = true;
                	this.flagAutoreTitolo = false;
                	this.flagCodice = false;
                }
                	
            }
        }
	})
</script>

</body>
</html>