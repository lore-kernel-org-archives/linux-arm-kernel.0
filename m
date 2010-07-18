From: michael.williamson@criticallink.com (Mike Williamson)
Date: Sun, 18 Jul 2010 13:29:32 -0400
Subject: [PATCH] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <1279324167.4526.85.camel@Joe-Laptop.home>
References: <E1OZlTF-0006NW-1I@wanda>
	<1279324167.4526.85.camel@Joe-Laptop.home>
Message-ID: <AANLkTil1t-KHom4wWLufDM2hPB24u_iGxlTwNXqXTjhI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/16 Joe Perches <joe@perches.com>

> On Fri, 2010-07-16 at 10:00 -0400, Michael Williamson wrote:
> > +static __init void mityomapl138_setup_lcd(void)
> > +{
> []
> > +                     pr_warning("mityomapl138_init: unknown LCD type :
> %s\n",
> > +                             peripheral_config.LCDConfig.PanelName);
>
> I think you'd be better off actually using the actual
> function name rather than the caller name
>
>                        pr_warning("%s: unknown LCD type: %s\n",
>                                   __func__,
> peripheral_config.LCDConfig.PanelName);
>
>
Absolutely.   Didn't catch those when shuffling around during cleanup /
etc.
I will clean these up and resubmit.

Thank you for the feedback.

-Mike

-- 
Michael Williamson
315-425-4045x230
www.criticallink.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100718/6b017c19/attachment.html>
