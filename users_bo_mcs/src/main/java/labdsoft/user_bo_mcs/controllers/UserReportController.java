package labdsoft.user_bo_mcs.controllers;

import labdsoft.user_bo_mcs.model.Top10ParkyDTO;
import labdsoft.user_bo_mcs.services.UserReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/userReport")
public class UserReportController {

    @Autowired
    private UserReportService service;

    @GetMapping("/top10Parky")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<List<Top10ParkyDTO>> getTop10Parky() {
        return new ResponseEntity<>(service.getTop10Parky(), HttpStatus.OK);
    }
}
