package com.pick.hotels.repository;

import java.util.List;

import com.pick.hotels.entity.RoomFileDto;

public interface RoomFileDao {

	void regist(RoomFileDto rfdto);

	List<RoomFileDto> get_list(int no);

	List<RoomFileDto> getlist(int room_no);

	RoomFileDto get(int no);

	void delete(int no);

}
