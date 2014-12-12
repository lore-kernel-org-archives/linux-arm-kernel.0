From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 12 Dec 2014 16:44:06 +0100
Subject: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED flag to fix USB Host
In-Reply-To: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <CABgxDoKKjwDf8+OuWiTjzpbGonshZ0fHXXMvSkJi1Z1U_7AsNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014-12-12 15:54 GMT+01:00 Julien CHAUVEAU
<julien.chauveau@neo-technologies.fr>:
> This patch adds CLK_IGNORE_UNUSED flag to hclk_usb_peri, hclk_usbotg0 and hclk_usbotg1
> because these clocks must remain enabled to use the USB controllers in host mode.
>
> This fixes a regression introduced by patch "clk: rockchip: disable unused clocks"
> https://lkml.kernel.org/g/1415092270-24932-1-git-send-email-kever.yang at rock-chips.com

Could you refer the commit id instead ? something like "commit <ID>
("title of the corresponding commit")  (and use scripts/checkpatch.pl
on your patch to be sure that the commit form is okay).


I confirm the regression.

Romain
