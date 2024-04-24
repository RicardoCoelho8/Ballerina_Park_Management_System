package labdsoft.user_bo_mcs.model;


import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.NoArgsConstructor;

@Embeddable
@NoArgsConstructor
public class TaxIdNumber {

    @Column(unique = true)
    private Integer nif;

    public TaxIdNumber(final Integer number) {
        this.nif = number;
    }

    public Integer number() {
        return this.nif;
    }



}
