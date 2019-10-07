package com.accenture.biblio.client;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
public class RestTemplateClient {

	public static final RestTemplateClient instance = new RestTemplateClient();
	public static final String BE_BASE_URL ="http://localhost:8080/biblioBE";
	
	private RestTemplate rtc = new RestTemplate();
	
	private RestTemplateClient() {
		// needed for singleton
	};
	
	public static RestTemplateClient getInstance() {
		
		return instance;
	}
	

	@SuppressWarnings("unchecked")
	public ResponseEntity<Object> call(HttpServletRequest httpServletRequest, String url, HttpMethod httpMethod, Map<String, Object> uriVariable, Class<?>... returnType) {

		if (uriVariable == null) {
			uriVariable = new HashMap<>();
		}
										
		HttpEntity<Object> request = new HttpEntity<Object>(null);
		if(returnType!=null && returnType.length==0){
			return rtc.exchange(BE_BASE_URL + url, httpMethod, request, Object.class, uriVariable);
		}
		else{
			return (ResponseEntity<Object>) rtc.exchange(BE_BASE_URL + url, httpMethod, request, returnType[0], uriVariable);
		}
	}
	
    public ResponseEntity<Object> call(HttpServletRequest httpServletRequest, String url, HttpMethod httpMethod, Map<String, Object> uriVariable, Object json, Class<?> returnType) {
        
        if (uriVariable == null) {
            uriVariable = new HashMap<>();
        }
        
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<String, String>();
        headers.add("HeaderName", "value");
        headers.add("Content-Type", "application/json");

        HttpEntity<Object> request = new HttpEntity<Object>(json, headers);

        if (httpMethod == HttpMethod.POST) {
            Object result = rtc.postForObject(BE_BASE_URL + url, request, returnType);
            return ResponseEntity.ok(result);
        } else {
            throw new IllegalArgumentException("Method " + httpMethod + " not managed");
            
        }
    }
	
}	