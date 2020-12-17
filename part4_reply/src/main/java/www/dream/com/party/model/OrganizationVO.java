package www.dream.com.party.model;

public class OrganizationVO extends PartyVO {
	public OrganizationVO() {}
	
	public OrganizationVO(Long id) {
		super(id);
	}

	@Override
	public String toString() {
		return "OrganizationVO [" + super.toString() + "]";
	}
}
