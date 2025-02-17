package com.sonkq.personal.service;

import com.sonkq.personal.dtos.request.UserRequest;
import com.sonkq.personal.dtos.response.UserResponse;

import java.util.List;

public interface UserService {
    UserResponse saveUser(UserRequest request);

    List<UserResponse> getUsers();

    UserResponse detailUser(String id);

    UserResponse updateUser(String id, UserRequest request);

    void deleteUser(String id);
}
