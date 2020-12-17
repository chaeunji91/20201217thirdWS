package www.dream.com.party.model.mapper;

import java.util.List;

import www.dream.com.party.model.PartyVO;

public interface PartyMapper {
	public List<PartyVO> selectAllParty(String partyType);
	public List<PartyVO> selectAllPartyWithContactPoint(String partyType);
}
