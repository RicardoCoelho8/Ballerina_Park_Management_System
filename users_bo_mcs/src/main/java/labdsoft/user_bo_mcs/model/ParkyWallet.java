package labdsoft.user_bo_mcs.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@NoArgsConstructor
@Getter
public class ParkyWallet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private Integer parkies;

    @OneToMany(cascade = CascadeType.ALL)
    private List<ParkyTransactionEvent> parkyEvents;

    public ParkyWallet(final Integer number) {
        this.parkies = number;
        parkyEvents = new ArrayList<>();
    }

    public Integer parkies() {
        return this.parkies;
    }

    public boolean addEvent(ParkyTransactionEvent event) {
        if (this.parkies + event.getAmount() < 0) {
            return false;
        }

        Boolean addEvent = this.parkyEvents.add(event);
        if (addEvent) {
            this.parkies = this.parkies + event.getAmount();
        }
        return addEvent;
    }

}
