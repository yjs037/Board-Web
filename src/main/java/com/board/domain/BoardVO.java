package com.board.domain;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date reg_date;
	private Date update_date;
}
