package labdsoft.park_bo_mcs.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import labdsoft.park_bo_mcs.communications.Subscribe;
import labdsoft.park_bo_mcs.dtos.park.BarrierLicenseReaderDTO;
import labdsoft.park_bo_mcs.dtos.park.BarrierDisplayDTO;
import labdsoft.park_bo_mcs.services.BarrierService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Tag(name = "Barrier", description = "Endpoints for managing barriers")
@RestController
@RequestMapping("/barriers")
class BarrierController {
    private static final Logger logger = LoggerFactory.getLogger(BarrierController.class);

    @Autowired
    private Subscribe subscribe;

    @Autowired
    private BarrierService service;

    @Operation(summary = "Entrance Optical Reader")
    @PostMapping("/entrance")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<BarrierDisplayDTO> entranceOpticalReader(@RequestBody BarrierLicenseReaderDTO barrierLicenseReaderDTO) {
        final BarrierDisplayDTO barrierDisplayDTO = service.entranceOpticalReader(barrierLicenseReaderDTO);
        return new ResponseEntity<>(barrierDisplayDTO, HttpStatus.OK);
    }

    @Operation(summary = "Exit Optical Reader")
    @PostMapping("/exit")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<BarrierDisplayDTO> exitOpticalReader(@RequestBody BarrierLicenseReaderDTO barrierLicenseReaderDTO) {
        final BarrierDisplayDTO barrierDisplayDTO = service.exitOpticalReader(barrierLicenseReaderDTO);
        return new ResponseEntity<>(barrierDisplayDTO, HttpStatus.OK);
    }
}