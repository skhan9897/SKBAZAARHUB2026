package com.skbazaarhub.platform.api;

import java.time.Instant;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/platform")
public class PlatformController {
    @GetMapping("/info")
    public Map<String, Object> info() {
        return Map.of(
            "application", "SK BazaarHub",
            "status", "RUNNING",
            "timestamp", Instant.now().toString(),
            "message", "Shared commerce platform API is reachable"
        );
    }
}
