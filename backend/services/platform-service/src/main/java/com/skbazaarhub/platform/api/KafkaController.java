package com.skbazaarhub.platform.api;

import com.skbazaarhub.platform.service.KafkaProducerService;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/platform/kafka")
public class KafkaController {

    private final KafkaProducerService producerService;

    public KafkaController(KafkaProducerService producerService) {
        this.producerService = producerService;
    }

    @PostMapping("/publish")
    public Map<String, String> publish(
            @RequestBody Map<String, String> request) {

        String message = request.get("message");

        if (message == null || message.isBlank()) {
            throw new IllegalArgumentException("Message cannot be empty");
        }

        producerService.sendMessage(message);

        return Map.of(
            "status", "SUCCESS",
            "message", "Kafka event submitted successfully"
        );
    }
}
