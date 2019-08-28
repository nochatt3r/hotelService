package com.pick.hotels.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pick.hotels.entity.HotelDto;

@Repository
public class HotelDaoImpl implements HotelDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean regist(HotelDto hotelDto) {
		try {
			System.out.println(hotelDto.getHotel_zip_code());
			System.out.println(hotelDto.getHotel_zip_code().length());
			sqlSession.insert("hotel.regist", hotelDto);
			return true;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public List<HotelDto> list(String seller_id) {
		return sqlSession.selectList("hotel.list",seller_id);
	}

}
