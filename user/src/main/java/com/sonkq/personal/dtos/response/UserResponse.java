package com.sonkq.personal.dtos.response;

import com.sonkq.personal.domain.User;
import jakarta.persistence.Column;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.BeanUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Getter
@Setter
@RequiredArgsConstructor
public class UserResponse {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNo;
    private String zipCode;

    public UserResponse(User user) {
        BeanUtils.copyProperties(user, this);
    }
}
