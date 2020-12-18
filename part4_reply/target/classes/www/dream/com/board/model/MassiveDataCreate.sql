insert into T_Reply(id, title, content, writer_id, original_id, obj_type, board_id)
	values(seq4Reply_id.nextval, '무궁한 발전 기원', '많은 사람들에게 도움을...', 3, null, 'post', 3);

insert into T_Reply(id, title, content, writer_id, obj_type, board_id)
select seq4Reply_id.nextval, title, content, writer_id, obj_type, board_id
  from T_Reply
 where board_id = 3;

insert into T_Reply(id, original_id, content, writer_id, obj_type)
select seq4Reply_id.nextval, original_id, content, writer_id, obj_type
  from T_Reply
 where original_id = 2;
 
 delete from T_Reply where original_id is null and obj_type='reply';
 
 select *
   from T_Reply r
 where obj_type='reply'
    and exists (
    select 1 
      from T_Reply rr 
     where r.id = rr.original_id);
     
--2번 글에 달린 모든 하위 요소 다 조회하기
 select *
   from t_reply
  start with id = 2
 connect by prior id = original_id;

 
 