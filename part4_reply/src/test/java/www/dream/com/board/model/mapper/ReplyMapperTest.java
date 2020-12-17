package www.dream.com.board.model.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.board.model.ReplyVO;
import www.dream.com.framework.model.Criteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
public class ReplyMapperTest {
	@Autowired
	private ReplyMapper replyMapper;
	
	@Test
	public void findPostWithPaging() {
		try { 
			for (ReplyVO reply : replyMapper.findPostWithPaging(3L, new Criteria()))
				System.out.println(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testFindAllPostWithReply() {
		try { 
			for (ReplyVO reply : replyMapper.findAllPostWithReply(1L))
				System.out.println(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testFindAllReply() {
		try { 
			for (ReplyVO reply : replyMapper.findAllReply(2L))
				System.out.println(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testFindReplyWithReply() {
		try { 
			for (ReplyVO reply : replyMapper.findPostWithReply(3L))
				System.out.println(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
