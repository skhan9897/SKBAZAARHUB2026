package com.skbazaarhub.platform;

import org.springframework.kafka.annotation.EnableKafka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableKafka
public class PlatformServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(PlatformServiceApplication.class, args);
    }
}

