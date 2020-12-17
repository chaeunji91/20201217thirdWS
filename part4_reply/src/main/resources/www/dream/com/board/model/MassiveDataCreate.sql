insert into T_Reply(id, title, content, writer_id, obj_type, board_id)
select seq4Reply_id.nextval, title, content, writer_id, obj_type, board_id
  from T_Reply
 where board_id = 3;
