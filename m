From: julien.chauveau@neo-technologies.fr (NEO-Technologies / Julien CHAUVEAU)
Date: Fri, 12 Dec 2014 19:01:23 +0100
Subject: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED flag to fix USB Host
In-Reply-To: <CABgxDoKKjwDf8+OuWiTjzpbGonshZ0fHXXMvSkJi1Z1U_7AsNA@mail.gmail.com>
References: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <CABgxDoKKjwDf8+OuWiTjzpbGonshZ0fHXXMvSkJi1Z1U_7AsNA@mail.gmail.com>
Message-ID: <E20CB6ED-61C3-40B5-84E5-95B2A1F4B8FB@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Le 12 d?c. 2014 ? 16:44, Romain Perier <romain.perier@gmail.com> a ?crit :
> 
> Hi,
> 
> 2014-12-12 15:54 GMT+01:00 Julien CHAUVEAU
> <julien.chauveau@neo-technologies.fr>:
>> This patch adds CLK_IGNORE_UNUSED flag to hclk_usb_peri, hclk_usbotg0 and hclk_usbotg1
>> because these clocks must remain enabled to use the USB controllers in host mode.
>> 
>> This fixes a regression introduced by patch "clk: rockchip: disable unused clocks"
>> https://lkml.kernel.org/g/1415092270-24932-1-git-send-email-kever.yang at rock-chips.com
> 
> Could you refer the commit id instead ? something like "commit <ID>
> ("title of the corresponding commit ?)  

OK, I'll resubmit with commit 78eaf6095cc7 ("clk: rockchip: disable unused clocks").

> (and use scripts/checkpatch.pl
> on your patch to be sure that the commit form is okay).
> 

That?s already done:

scripts/checkpatch.pl 0001-clk-rockchip-add-CLK_IGNORE_UNUSED-flag-to-fix-USB-H.patch 
total: 0 errors, 0 warnings, 30 lines checked

> 
> I confirm the regression.
> 
> Romain
