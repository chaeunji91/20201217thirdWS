insert into T_Reply(id, title, content, writer_id, original_id, obj_type, board_id)
	values(seq4Reply_id.nextval, '무궁한 발전 기원', '많은 사람들에게 도움을...', 3, null, 'post', 3);

insert into T_Reply(id, title, content, writer_id, obj_type, board_id)
select seq4Reply_id.nextval, title, content, writer_id, obj_type, board_id
  from T_Reply
 where board_id = 3;
