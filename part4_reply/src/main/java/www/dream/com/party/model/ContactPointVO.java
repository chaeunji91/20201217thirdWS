package www.dream.com.party.model;

import www.dream.com.framework.model.CommonMngInfoVO;

public class ContactPointVO extends CommonMngInfoVO {
	private String typeName;
	private String contactPoint;
	
	@Override
	public String toString() {
		return "typeName=" + typeName + ", contactPoint=" + contactPoint + ", regDate=" + regDate;
	}

	
}
