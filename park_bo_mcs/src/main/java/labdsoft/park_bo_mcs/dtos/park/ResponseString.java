package labdsoft.park_bo_mcs.dtos.park;

import labdsoft.park_bo_mcs.models.park.SpotType;
import labdsoft.park_bo_mcs.models.park.SpotVehicleType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ResponseString {
    private String response;
}
