package com.privilegecard.privilegecard.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/**
 * Matches the DB hashing: md5(md5(md5(rawPassword)))
 * where each md5() returns a lowercase hex string that is fed into the next md5().
 * Same behavior as PostgreSQL's md5().
 */
public class TripleMd5PasswordEncoder implements PasswordEncoder {

    @Override
    public String encode(CharSequence rawPassword) {
        return md5Triple(rawPassword == null ? "" : rawPassword.toString());
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        if (rawPassword == null || encodedPassword == null) return false;
        return md5Triple(rawPassword.toString()).equalsIgnoreCase(encodedPassword.trim());
    }

    private String md5Triple(String raw) {
        String value = raw;
        for (int i = 0; i < 3; i++) {
            value = md5Hex(value);
        }
        return value;
    }

    private String md5Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(32);
            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new IllegalStateException("MD5 algorithm unavailable", e);
        }
    }
}