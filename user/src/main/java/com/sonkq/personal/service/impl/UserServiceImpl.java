package com.sonkq.personal.service.impl;

import com.sonkq.personal.domain.User;
import com.sonkq.personal.dtos.request.UserRequest;
import com.sonkq.personal.dtos.response.UserResponse;
import com.sonkq.personal.repository.UserRepository;
import com.sonkq.personal.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    @Override
    public UserResponse saveUser(UserRequest request) {
        User user = new User(request);
        return new UserResponse(userRepository.save(user));
    }

    @Override
    public List<UserResponse> getUsers() {
        List<User> users = userRepository.findAll();
        return users.stream().map(student -> new UserResponse(userRepository.save(student))).collect(Collectors.toList());
    }

    @Override
    public UserResponse detailUser(String id) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        return new UserResponse(user);
    }

    @Override
    public UserResponse updateUser(String id, UserRequest request) {
        User user = userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
        user.updateUser(request);
        userRepository.save(user);
        return new UserResponse(user);
    }

    @Override
    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }
}
