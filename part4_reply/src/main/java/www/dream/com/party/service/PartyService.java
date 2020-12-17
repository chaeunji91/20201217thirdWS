package www.dream.com.party.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.dream.com.party.model.PartyVO;
import www.dream.com.party.model.mapper.PartyMapper;

@Service
public class PartyService {
	@Autowired
	private PartyMapper partyMapper;
	
	public List<PartyVO> selectAllParty(String partyType) {
		return partyMapper.selectAllParty(partyType);
	}
	
	public List<PartyVO> selectAllPartyWithContactPoint(String partyType) {
		return partyMapper.selectAllPartyWithContactPoint(partyType);
	}

}
