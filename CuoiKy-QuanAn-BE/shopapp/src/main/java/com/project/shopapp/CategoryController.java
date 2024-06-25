package com.project.shopapp;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("api/v1/categories")
public class CategoryController {
    //Hiện tất cả các categories
    @GetMapping("") //http://localhost:8088/api/v1/categories
    public ResponseEntity<String> getAllCategories(){
        return ResponseEntity.ok("chao ban");
    }
}
