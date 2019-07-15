package br.ufu.ileel.voicecontroller;

import java.io.IOException;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class VoiceService {
	
	private Logger logger;

	@Autowired
    public VoiceService(Logger logger) {
        this.logger = logger;
    }
	
	@GetMapping("/ping")
	public String hello() {
		logger.info("ping");
		return "pong";
	}

	@PostMapping("/voicechat")
    public byte[] talk(@RequestParam("uploadfile") MultipartFile file) {
		logger.info("talk");
		try {
        	RestTemplate restTemplate = new RestTemplate();
        	
        	Object response = restTemplate.postForEntity("lab-deepspeech:8080", file, Object.class);
        	
        	String respChat = response.toString();
        	logger.info("respChat: {}", respChat);
        	
        	Object responseTacotron = restTemplate.postForEntity("lab-tacotron:80", "bed beach sink", Object.class);
        	logger.info("responseTacotron: {}", responseTacotron.toString());
        	
			return file.getBytes();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
    }
}
