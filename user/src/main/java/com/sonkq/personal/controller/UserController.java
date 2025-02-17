package com.sonkq.personal.controller;

import com.sonkq.personal.dtos.request.UserRequest;
import com.sonkq.personal.dtos.response.UserResponse;
import com.sonkq.personal.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;

    @PostMapping
    public ResponseEntity<UserResponse> saveUser(@RequestBody @Valid UserRequest request) {
        return new ResponseEntity<>(userService.saveUser(request), HttpStatus.OK);
    }

    @CrossOrigin
    @GetMapping
    public ResponseEntity<List<UserResponse>> getUsers() {
        return new ResponseEntity<>(userService.getUsers(), HttpStatus.OK);
    }

    @CrossOrigin
    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> detailUser(@PathVariable String id) {
        return new ResponseEntity<>(userService.detailUser(id), HttpStatus.OK);
    }

    @PatchMapping("/{id}")
    public ResponseEntity<UserResponse> updateUser(@PathVariable String id, @RequestBody @Valid UserRequest request) {
        return new ResponseEntity<>(userService.updateUser(id, request), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable String id) {
        userService.deleteUser(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}
