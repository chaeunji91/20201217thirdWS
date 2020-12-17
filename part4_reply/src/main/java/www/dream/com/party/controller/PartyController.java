package www.dream.com.party.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import www.dream.com.party.service.PartyService;

@Controller
@RequestMapping("/party/*")
public class PartyController {
	@Autowired
	private PartyService partyService;
		
	@RequestMapping("listParty")
	public void list(@RequestParam("type") String partyType, Model model) {
		model.addAttribute("listParty", partyService.selectAllParty(partyType));
	}
}
