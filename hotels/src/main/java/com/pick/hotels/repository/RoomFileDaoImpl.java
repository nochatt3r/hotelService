package com.pick.hotels.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pick.hotels.entity.RoomFileDto;

@Repository
public class RoomFileDaoImpl implements RoomFileDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void regist(RoomFileDto rfdto) {
		sqlSession.insert("roomFile.regist", rfdto);
		
	}

}