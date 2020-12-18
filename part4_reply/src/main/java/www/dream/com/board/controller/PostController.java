package www.dream.com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.dream.com.board.model.PostVO;
import www.dream.com.board.service.PostService;
import www.dream.com.framework.model.Criteria;
import www.dream.com.party.model.PersonVO;

@Controller
@RequestMapping("/post/*")
public class PostController {
	//함수 배치 순서는 목록, 상세, 생성, 수정, 삭제
	@Autowired
	private PostService postService;
		
	@GetMapping("listPost")
	public void listPost(@RequestParam("boardId") long boardId, Criteria criteria, Model model) {
		long countTotal = postService.countTotalPostWithPaging(boardId, criteria);
		criteria.setTotalDataCount(countTotal);

		model.addAttribute("listPost", postService.findPostWithPaging(boardId, criteria));
		model.addAttribute("criteria", criteria);
		model.addAttribute("boardId", boardId);
	}
	
	/** 
	 * "상세 조회 화면 열자", "수정 화면 열자"가 어떻게 불려졌나에 따라 자동으로 해당 JSP를 찾아가 가겠거니  
	 */
	@GetMapping({"postDetail", "modifyPost"})
	public void showDetailPost(@RequestParam("boardId") long boardId, @RequestParam("id") long id, Criteria criteria, Model model) {
		PostVO post = (PostVO) postService.findPostById(id);
		model.addAttribute("post", post);
		model.addAttribute("criteria", criteria);
		model.addAttribute("boardId", post.getBoardId());
	}

	/** 
	 * 등록 화면 열자
	 */
	@GetMapping("registerPost")
	public void registerPost(@RequestParam("boardId") long boardId, Criteria criteria, Model model) {
		model.addAttribute("criteria", criteria);
		model.addAttribute("boardId", boardId);
	}
	@PostMapping("registerPost")
	public String registerPost(PostVO post, RedirectAttributes rttr) {
		//로그인 처리가 된 다음에 그 정보를 활용하는 스타일로 바꿀... 디폴트 사용자로 홍길동을 임시 사용할거야
		post.setWriter(new PersonVO(3L));
		postService.registerPost(post);
		rttr.addFlashAttribute("result", post.getId());

		rttr.addAttribute("boardId", post.getBoardId());
		return "redirect:/post/listPost";
	}

	/** 
	 * 수정 처리하자
	 */
	@PostMapping("modifyPost")
	public String modifyPost(@RequestParam("boardId") long boardId, @ModelAttribute("criteria") Criteria criteria, PostVO post, RedirectAttributes rttr) {
		if (postService.updatePost(post)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("result", "success");
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("boardId", boardId);
		return "redirect:/post/listPost";
	}

	/** 
	 * 삭제 기능 만들자
	 */
	@PostMapping("removePost")
	public String removePost(@RequestParam("boardId") long boardId, Criteria criteria, PostVO post, RedirectAttributes rttr) {
		if (postService.removePost(post)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("boardId", boardId);
		return "redirect:/post/listPost";
	}
}
