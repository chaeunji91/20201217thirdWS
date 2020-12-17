drop sequence seq4Board_id;
drop sequence seq4Reply_id;

drop table T_Board;

create sequence seq4Board_id;
create sequence seq4Reply_id;

--id, name
create table T_Board(
	id					numeric(22, 0) primary key,
	name				varchar2(100),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate
);
insert into T_Board(id, name)
	values(seq4Board_id.nextval, '공지사항');
insert into T_Board(id, name)
	values(seq4Board_id.nextval, 'FAQ');
insert into T_Board(id, name)
	values(seq4Board_id.nextval, '자유게시판');

--id, content, writer_id, original_id, obj_type, title, board_id, reg_date, update_date
create table T_Reply(
	id					numeric(22, 0) primary key,
	original_id			numeric(22, 0),
	content				varchar2(4000),
	writer_id			numeric(22, 0),
	obj_type			varchar2(100),	--reply, post
	--	post일 경우의 추가 정보
	title				varchar2(500),
	board_id			numeric(22, 0),
	--공통 관리 정보
	reg_date			date default sysdate,
	update_date			date default sysdate
);
create index idx_writerOnRply on T_Reply(writer_id);
create index idx_orgOnRply on T_Reply(original_id);
create index idx_boardOnRply on T_Reply(board_id);

ALTER INDEX SYS_C007477 RENAME TO pk_reply;
