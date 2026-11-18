package com.skbazaarhub.platform.api;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(PlatformController.class)
class PlatformControllerTest {
    @Autowired MockMvc mvc;

    @Test
    void returnsPlatformInfo() throws Exception {
        mvc.perform(get("/api/v1/platform/info"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.application").value("SK BazaarHub"))
            .andExpect(jsonPath("$.status").value("RUNNING"));
    }
}
