package com.sonkq.personal.domain;

import com.sonkq.personal.dtos.request.UserRequest;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.beans.BeanUtils;

@Entity
@Table(name = "tbl_user")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @GeneratedValue(generator = "UUID")
    @Column(name = "id")
    private String id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "email")
    private String email;

    @Column(name = "phone_no")
    private String phoneNo;

    @Column(name = "zip_code")
    private String zipCode;

    public User(UserRequest request) {
        BeanUtils.copyProperties(request, this);
    }

    public void updateUser(UserRequest request) {
        BeanUtils.copyProperties(request, this);
    }
}
