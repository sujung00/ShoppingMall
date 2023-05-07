package com.shoppingmall.address;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/address")
@Controller
public class AddressController {

	@RequestMapping("/address_view")
	public String addressView(Model model) {
		model.addAttribute("view", "/address/addressView");
		return "template/layout";
	}
}
