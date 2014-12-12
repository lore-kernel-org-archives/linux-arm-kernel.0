From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 12 Dec 2014 19:02:24 +0100
Subject: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED flag to fix USB Host
In-Reply-To: <CABgxDoKKjwDf8+OuWiTjzpbGonshZ0fHXXMvSkJi1Z1U_7AsNA@mail.gmail.com>
References: <1418396066-31360-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <CABgxDoKKjwDf8+OuWiTjzpbGonshZ0fHXXMvSkJi1Z1U_7AsNA@mail.gmail.com>
Message-ID: <3548627.UnLcRkWMrC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 12. Dezember 2014, 16:44:06 schrieb Romain Perier:
> Hi,
> 
> 2014-12-12 15:54 GMT+01:00 Julien CHAUVEAU
> 
> <julien.chauveau@neo-technologies.fr>:
> > This patch adds CLK_IGNORE_UNUSED flag to hclk_usb_peri, hclk_usbotg0 and
> > hclk_usbotg1 because these clocks must remain enabled to use the USB
> > controllers in host mode.
> > 
> > This fixes a regression introduced by patch "clk: rockchip: disable unused
> > clocks"
> > https://lkml.kernel.org/g/1415092270-24932-1-git-send-email-kever.yang at ro
> > ck-chips.com
> Could you refer the commit id instead ? something like "commit <ID>
> ("title of the corresponding commit")  (and use scripts/checkpatch.pl
> on your patch to be sure that the commit form is okay).

I can also fix this up when applying the patch


> 
> 
> I confirm the regression.

instead of prose-confirmation please provide appropriate tags, like

Reviewed-by: Romain Perier <romain.perier@gmail.com>
Tested-by: Romain Perier <romain.perier@gmail.com>

Tested-by when you have tested the fix on actual hardware and Reviewed-by when 
you have reviewed the actual change for correctnes


Thanks
Heiko
