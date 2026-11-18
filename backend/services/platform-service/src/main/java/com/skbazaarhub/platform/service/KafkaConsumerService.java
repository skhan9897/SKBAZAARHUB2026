package com.skbazaarhub.platform.service;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class KafkaConsumerService {

    @KafkaListener(
        topics = "sk-bazaarhub-test",
        groupId = "sk-bazaarhub-group"
    )
    public void consume(String message) {
        System.out.println("Kafka Message Received: " + message);
    }
}
