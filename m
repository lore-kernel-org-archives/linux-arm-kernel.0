From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 19 Jul 2010 12:05:10 +0530
Subject: [PATCH] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <AANLkTil1t-KHom4wWLufDM2hPB24u_iGxlTwNXqXTjhI@mail.gmail.com>
References: <E1OZlTF-0006NW-1I@wanda>
	<1279324167.4526.85.camel@Joe-Laptop.home>
	<AANLkTil1t-KHom4wWLufDM2hPB24u_iGxlTwNXqXTjhI@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7BD3A06@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mike,

On Sun, Jul 18, 2010 at 22:59:32, Mike Williamson wrote:
>
>
> 2010/7/16 Joe Perches <joe@perches.com>
>
>
>       On Fri, 2010-07-16 at 10:00 -0400, Michael Williamson wrote:
>       > +static __init void mityomapl138_setup_lcd(void)
>       > +{
>
>       []
>
>       > +                     pr_warning("mityomapl138_init: unknown
> LCD type : %s\n",
>       > +
> peripheral_config.LCDConfig.PanelName);
>
>
>       I think you'd be better off actually using the actual
>       function name rather than the caller name
>
>                              pr_warning("%s: unknown LCD type: %s\n",
>                                         __func__,
> peripheral_config.LCDConfig.PanelName);
>
>
>
>
> Absolutely.   Didn't catch those when shuffling around during cleanup /
> etc.
> I will clean these up and resubmit.
>
> Thank you for the feedback.

Can you can you please configure your e-mail client to send
plain text and not HTML? I don't think this response of yours
reached subscribers of ARM linux kernel mailing list.

Thanks,
Sekhar
