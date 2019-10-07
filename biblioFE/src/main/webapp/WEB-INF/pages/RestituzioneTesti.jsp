<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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

<title>Restituzione Testi</title>

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
						class="dropdown-item" href="RestituzioneTesti">Restituzione testi</a>
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

								<select v-model="codice_ISBN" class="form-control">
									<option selected disabled hidden>Seleziona testo da
										restituire:</option>
									<option v-for="i in infoTesti" v-bind:value="i">{{i.codice_ISBN}}
										({{i.titolo}})</option>
								</select><br> <strong>Data Restituzione:</strong> <input type="date"
									class="form-control" v-model="data_Restituzione"
									required="required"><br>

								<button class="btn btn-success">Submit</button>

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script src="https://unpkg.com/vue-toasted"></script>

<script>
Vue.use(Toasted)
new Vue({
	  el: '#app',
        data() {
            return {
              codice_ISBN: '',
              data_Restituzione: '',
              info: null,
              infoTesti: null
            };
        },
        mounted () {
        	{
  			  axios
  		      .get('http://localhost:8080/biblioFE/getTestiInPrestito')
  		      .then(response => (this.infoTesti = response.data))	
  	  		}
        },
        methods: {
            formSubmit(e) {
                e.preventDefault();
                let currentObj = this;
                axios.post('http://localhost:8080/biblioFE/RestituzioneTesto', {
                    parametroRicerca: currentObj.codice_ISBN.codice_ISBN,
                    parametroData: currentObj.data_Restituzione
                })
                .then(function (response) {
                    currentObj.info = response.data;
                    currentObj.toast(currentObj.info.messaggio, currentObj.info.tipoMessaggio);
                    if(currentObj.info.tipoMessaggio == 'success'){
                    	axios
            		      .get('http://localhost:8080/biblioFE/getTestiInPrestito')
            		      .then(response => (currentObj.infoTesti = response.data))	
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
            }
        }
    })
</script>
</html>