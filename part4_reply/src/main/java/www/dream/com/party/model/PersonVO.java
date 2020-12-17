package www.dream.com.party.model;

public class PersonVO extends PartyVO {
	private String loginId;
	private String password;
	private boolean gender;
	
	public PersonVO() {}

	public PersonVO(Long id) {
		super(id);
	}
	
	@Override
	public String toString() {
		return "PersonVO [" + super.toString() 
			+ ", loginId=" + loginId + ", password=" + password + ", gender=" + gender + "]";
	}

	
}
