package com.accenture.biblio.controller;

import java.io.Console;

import javax.servlet.http.HttpServletRequest;

import com.accenture.biblio.common.beans.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.accenture.biblio.client.RestTemplateClient;

@Controller
public class HomeController {
	
	public static final String BASE_URL = "/home";
	public static final String HOME_INDEX = "home";
	
	@Autowired
	RestTemplateClient rtc;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = BASE_URL)
	public String home() {		
		return "home";
	}
	
	@RequestMapping(value = "/InserisciGenere")
	public String inserimentoGenere() {	
		return "InserisciGenere";
	}
	
	@RequestMapping(value = "/ElencoGeneri")
	public String elencoGeneri() {	
		return "generiTest";
	}
	
	@RequestMapping(value = "/SaveGenere", method = RequestMethod.POST)
	public ResponseEntity<Object> inserisciGenere(HttpServletRequest request, @RequestBody GenereDTO genere) {	
		ResponseEntity<Object> response = rtc.call(request, "/genere/saveGenere", HttpMethod.POST, null, genere, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/SaveSocio", method = RequestMethod.POST)
	public ResponseEntity<Object> inserisciSocio(HttpServletRequest request, @RequestBody SocioDTO socio) {	
		ResponseEntity<Object> response = rtc.call(request, "/socio/saveSocio", HttpMethod.POST, null, socio, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/SavePrestito", method = RequestMethod.POST)
	public ResponseEntity<Object> savePrestito(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/prestito/savePrestito", HttpMethod.POST, null, parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/SaveTesto", method = RequestMethod.POST)
	public ResponseEntity<Object> inserisciTesto(HttpServletRequest request, @RequestBody TestoDTO testo) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/saveTesto", HttpMethod.POST, null, testo, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/deleteTesto", method = RequestMethod.POST)
	public ResponseEntity<Object> deleteTesto(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/deleteTesto", HttpMethod.POST, null, parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/deleteSocio", method = RequestMethod.POST)
	public ResponseEntity<Object> deleteSocio(HttpServletRequest request, @RequestBody SocioDTO socio) {	
		ResponseEntity<Object> response = rtc.call(request, "/socio/deleteSocio", HttpMethod.POST, null, socio, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/updateSocio", method = RequestMethod.POST)
	public ResponseEntity<Object> updateSocio(HttpServletRequest request, @RequestBody SocioDTO socio) {	
		ResponseEntity<Object> response = rtc.call(request, "/socio/updateSocio", HttpMethod.POST, null, socio, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getGenere", method = RequestMethod.POST)
	public ResponseEntity<Object> getGenere(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/genere/getGenere", HttpMethod.POST, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getGeneri", method = RequestMethod.GET)
	public ResponseEntity<Object> getGeneri(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/genere/list", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getSoci", method = RequestMethod.GET)
	public ResponseEntity<Object> getSoci(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/socio/list", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getSocio", method = RequestMethod.POST)
	public ResponseEntity<Object> getSocio(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/socio/getSocio", HttpMethod.POST, null , parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiDisponibili", method = RequestMethod.GET)
	public ResponseEntity<Object> getTestiDisponibili(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/list", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiInPrestito", method = RequestMethod.GET)
	public ResponseEntity<Object> getTestiInPrestito(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/listTestiInPrestito", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiLibri", method = RequestMethod.GET)
	public ResponseEntity<Object> getTestiLibri(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/listTestiLibri", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiRiviste", method = RequestMethod.GET)
	public ResponseEntity<Object> getTestiRiviste(HttpServletRequest request) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/listTestiRiviste", HttpMethod.GET, null,Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiByAutoreTitolo", method = RequestMethod.POST)
	public ResponseEntity<Object> getTestiByAutoreTitolo(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/listTestiByAutoreTitolo", HttpMethod.POST, null, parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/RestituzioneTesto", method = RequestMethod.POST)
	public ResponseEntity<Object> restituzioneTesto(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/prestito/restituzioneTesto", HttpMethod.POST, null, parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/getTestiByCodiceEditore", method = RequestMethod.POST)
	public ResponseEntity<Object> getTestiByCodiceEditore(HttpServletRequest request, @RequestBody Parametro parametro) {	
		ResponseEntity<Object> response = rtc.call(request, "/testo/listTestiByCodiceEditore", HttpMethod.POST, null, parametro, Object.class);
		return response;
	}
	
	@RequestMapping(value = "/RestituzioneTesti")
	public String restituzioneTesti() {	
		return "RestituzioneTesti";
	}
	
	@RequestMapping(value = "/InserisciSocio")
	public String inserisciSocio() {	
		return "InserisciSocio";
	}
	
	@RequestMapping(value = "/ElencoSoci")
	public String elencoSoci() {	
		return "ElencoSoci";
	}
	
	@RequestMapping(value = "/ElencoTesti")
	public String elencoTesti() {	
		return "ElencoTesti";
	}
	
	@RequestMapping(value = "/InserisciTesto")
	public String inserisciTesto() {	
		return "InserisciTesto";
	}
	
	@RequestMapping(value = "/ModificaSocio")
	public String modificaSocio() {	
		return "ModificaSocio";
	}
	
	@RequestMapping(value = "/RicercaTesto")
	public String ricercaTesto() {	
		return "RicercaTesto";
	}
}

	
