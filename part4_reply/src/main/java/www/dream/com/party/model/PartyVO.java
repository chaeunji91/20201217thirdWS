package www.dream.com.party.model;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import www.dream.com.framework.model.CommonMngInfoVO;

public class PartyVO extends CommonMngInfoVO {
	@Getter @Setter
	private long id;
	@Getter @Setter
	private String name;
	private Date birthDate;
	
	/* 연관 정보 정의 부분 */
	private List<ContactPointVO> listContactPoint;
	
	public PartyVO() {
	}
	
	public PartyVO(Long id) {
		super();
		this.id = id;
	}

	@Override
	public String toString() {
		return "id=" + id + ", name=" + name + ", birthDate=" + birthDate + ", regDate=" + regDate
				+ ", updateDate=" + updateDate + ", 연락처들 " + listContactPoint;
	}
}
