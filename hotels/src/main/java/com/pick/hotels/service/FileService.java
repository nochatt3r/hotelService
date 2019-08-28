package com.pick.hotels.service;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.pick.hotels.entity.AttractionFileDto;
import com.pick.hotels.entity.NoticeDto;

@Service
public interface FileService {
	NoticeDto save(MultipartFile file) throws IllegalStateException, IOException;

	void delete(String delete_file);
	
	AttractionFileDto attraction_save(MultipartFile file, AttractionFileDto afdto) throws IllegalStateException, IOException;

	void attraction_delete(int no);
	
}
