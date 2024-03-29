package labdsoft.park_bo_mcs.models.park;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Spot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, unique = true)
    private Long spotID;

    @Column(nullable = false)
    private String spotNumber;

    @Enumerated
    private SpotType spotType;

    @Enumerated
    private SpotVehicleType spotVehicleType;

    @Column(nullable = false)
    private String floorLevel;

    @Column(nullable = false)
    private boolean occupied;

    @Column(nullable = false)
    private boolean operational;

    @Column(nullable = false)
    private Long parkID;
}
