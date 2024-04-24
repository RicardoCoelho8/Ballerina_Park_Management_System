package labdsoft.user_bo_mcs.model;

import jakarta.persistence.Embeddable;
import lombok.NoArgsConstructor;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@NoArgsConstructor
@Embeddable
public class Password {
    private String password;

    public Password(final String password) {
        this.password = password;
    }

    public String password() {
        return this.password;
    }

    public static void isValidPreEncodedPassword(final String password) {
        Pattern p = Pattern.compile("(?=.*\\b)(?=.*[a-z])(?=.*[A-Z])((?=.*\\W)|(?=.*_))^[^ ]+$");
        Matcher m = p.matcher(password);
        if(!(password.length() > 10 &&  m.matches() && password.length() < 20)) {
            throw new IllegalArgumentException("Invalid password");
        }
    }

}
