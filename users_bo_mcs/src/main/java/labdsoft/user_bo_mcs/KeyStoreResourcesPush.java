package labdsoft.user_bo_mcs;

import org.springframework.aot.hint.RuntimeHints;
import org.springframework.aot.hint.RuntimeHintsRegistrar;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportRuntimeHints;

@ImportRuntimeHints(KeyStoreResourcesPush.CertificateResourcesRegistrar.class)
@Configuration
public class KeyStoreResourcesPush {

    static class CertificateResourcesRegistrar implements RuntimeHintsRegistrar {

        @Override
        public void registerHints(RuntimeHints hints, ClassLoader classLoader) {
            hints.resources().registerPattern("*.p12");
        }
    }

}