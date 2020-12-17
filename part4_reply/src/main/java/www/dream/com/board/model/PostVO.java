package www.dream.com.board.model;

import lombok.Getter;
import lombok.Setter;
import www.dream.com.framework.display.Caption;
import www.dream.com.framework.display.Caption.WhenUse;

public class PostVO extends ReplyVO {
	@Getter
	@Caption(whenUse=WhenUse.all, caption="게시글 제목")
	private String title;
	@Getter
	private long boardId;
	
	public PostVO() {
		int i = 0;
		i++;
	}
	
	public PostVO(Long id) {
		super(id);
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setBoardId(long boardId) {
		this.boardId = boardId;
	}

	@Override
	public String toString() {
		return "PostVO [" + toString4ChildPrev() + ", title=" + title + toString4ChildPost() + "]";
	}
}
