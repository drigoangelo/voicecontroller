package br.ufu.ileel.voicecontroller;

import java.io.IOException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class VoiceService {
	
	@GetMapping("/hello")
	public String hello() {
		return "hello world";
	}

	@PostMapping("/voicechat")
    public byte[] uploadMultipartFile(@RequestParam("uploadfile") MultipartFile file) {
        try {
        	RestTemplate restTemplate = new RestTemplate();
        	
        	restTemplate.postForEntity("lab-deepspeech:8080", file, Object.class);
        	
			return file.getBytes();
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
    }
}
