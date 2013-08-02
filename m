From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Aug 2013 00:24:16 -0700
Subject: [PATCHv4 29/33] CLK: omap: add omap3 clock init file
In-Reply-To: <51F928E8.9020806@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-30-git-send-email-t-kristo@ti.com>
 <51F81FD7.2060707@ti.com> <20130731063512.GP7656@atomide.com>
 <51F928E8.9020806@ti.com>
Message-ID: <20130802072415.GW7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [130731 08:17]:
> On 07/31/2013 09:35 AM, Tony Lindgren wrote:
> >* Nishanth Menon <nm@ti.com> [130730 13:26]:
> >>
> >>Tony and a lot of people is not going to like removing support for
> >>non-dt boot for OMAP3 before "it's time is due" ;)
> >
> >I think the only showstopper for that is that we need the
> >pending pinctrl changes merged first to keep off-idle working.
> >So the omap3 legacy code removal probably needs to wait until
> >v3.13 merge window. For omap4 and am33xx we can do it now.
> 
> I'll modify the series in such way that OMAP3 retains the legacy
> clock data within the kernel for now, and will use either DT or
> kernel data based on init type. Kernel data can then be removed when
> time is ripe for it.

OK thanks sounds good to me.

Regards,

Tony
