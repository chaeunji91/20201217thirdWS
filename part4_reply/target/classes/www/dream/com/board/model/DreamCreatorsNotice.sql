insert into T_Reply(id, title, content, writer_id, original_id, obj_type, board_id)
	values(seq4Reply_id.nextval, '무궁한 발전 기원', '많은 사람들에게 도움을...', 1, null, 'post', 1);

insert into T_Reply(id, title, content, writer_id, original_id, obj_type, board_id)
	values(seq4Reply_id.nextval, '직원 모집 공고', '열의에 가득찬 사람들 오세요', 1, null, 'post', 1);
--댓글
insert into T_Reply(id, content, writer_id, original_id, obj_type)
	values(seq4Reply_id.nextval, '현지야 너는 꼭 지원해줘!', 1, 2, 'reply');
insert into T_Reply(id, content, writer_id, original_id, obj_type)
	values(seq4Reply_id.nextval, '고양아 너도 꼭 지원해줘!', 1, 2, 'reply');
--7번의 대댓글
insert into T_Reply(id, content, writer_id, original_id, obj_type)
	values(seq4Reply_id.nextval, '레오 너 나 얼마나 기다리게 할거야?', 1, 3, 'reply');
insert into T_Reply(id, content, writer_id, original_id, obj_type)
	values(seq4Reply_id.nextval, '이디 너 이제는 끝이야', 1, 3, 'reply');
	