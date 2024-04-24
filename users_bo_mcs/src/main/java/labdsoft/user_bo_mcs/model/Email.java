package labdsoft.user_bo_mcs.model;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.NoArgsConstructor;

@Embeddable
@NoArgsConstructor
public class Email {
    
    @Column(length = 40, unique = true)
    private String email;

    public Email(final String email) {
        this.email = email;
    }

    public String email() {
        return this.email;
    }

}
