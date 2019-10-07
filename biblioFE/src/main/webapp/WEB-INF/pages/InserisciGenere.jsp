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

<title>Inserisci Genere</title>

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
						<div class="card-header">Gestione generi</div>

						<div class="card-body">

							<strong>Elenco generi:</strong> <select v-model="selected"
								class="form-control">
								<option value="" selected disabled hidden>Seleziona
									genere</option>
								<option v-for="i in info" v-bind:value="i">{{
									i.descrizione }}</option>
							</select> <br>
							<button @click="deleteFun" class="btn btn-success">Elimina</button>
							<br>


							<form @submit="formSubmit">

								<strong>Descrizione:</strong> <input class="form-control"
									v-model="descrizione" required="required"><br>

								<button class="btn btn-success">Salva</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
new Vue({
	  el: '#app',
        data() {
            return {
              descrizione: '',
              output: '',
              output1: '',
              info: null,
              selected: ''
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
                axios.post('http://localhost:8080/biblioFE/SaveGenere', {
                    descrizione: this.descrizione
                })
                .then(function (response) {
                    currentObj.output = response.data;
                    if(currentObj.output === 0){
                    	alert("Genere inserito con successo!");
                    	axios
          		      	.get('http://localhost:8080/biblioFE/getGeneri')
          		      	.then(function (response) {
                          currentObj.info = response.data;})
                    }
                    else if(currentObj.output < 0)
                    	alert("Genere già presente!");
                })
                .catch(function (error) {
                    currentObj.output = error;
                });
            },
            deleteFun(){
            	  let currentObj = this;
				  axios.post('http://localhost:8080/biblioBE/genere/eliminateGenere', {
	                    codice_genere: this.selected.codice_genere, descrizione: ''
	                })
	                .then(function () {
	                	axios
	    		      	.get('http://localhost:8080/biblioFE/getGeneri')
	    		      	.then(function (response) {
	                    currentObj.info = response.data;})  
	                })
				  
			  }
        }
    })
</script>

</body>
</html>