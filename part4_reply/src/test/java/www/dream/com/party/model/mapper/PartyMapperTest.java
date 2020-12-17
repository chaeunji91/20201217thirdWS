package www.dream.com.party.model.mapper;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.party.model.PartyVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
public class PartyMapperTest {
	@Autowired
	private PartyMapper partyMapper;
	
	@Test
	public void testPerson() {
		try { 
		assertNotNull(partyMapper);
		for (PartyVO party : partyMapper.selectAllParty("organization"))
			System.out.println(party);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testPersonWithCP() {
		try { 
		assertNotNull(partyMapper);
		for (PartyVO party : partyMapper.selectAllPartyWithContactPoint("organization"))
			System.out.println(party);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
