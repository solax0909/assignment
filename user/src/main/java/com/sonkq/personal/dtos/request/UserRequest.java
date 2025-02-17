package com.sonkq.personal.dtos.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class UserRequest {
    @NotBlank(message = "First Name is require")
    private String firstName;
    @NotBlank(message = "Last Name is require")
    private String lastName;
    @NotBlank(message = "Email is require")
    @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._%+-]+\\.[a-zA-Z]{2,6}$", message = "Email must follow format: local@domain.extension")
    private String email;
    private String phoneNo;
    private String zipCode;
}
