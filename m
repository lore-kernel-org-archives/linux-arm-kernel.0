From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 15:11:07 -0800
Subject: [PATCH] ARM: OMAP2+: Use pdata quirks for wl12xx on the AM335x
 EV-MSK
In-Reply-To: <20140228225427.GT13624@atomide.com>
References: <1392806495-4874-1-git-send-email-kaloz@openwrt.org>
 <20140228225427.GT13624@atomide.com>
Message-ID: <20140228231106.GX13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140228 14:54]:
> * Imre Kaloz <kaloz@openwrt.org> [140219 02:44]:
> > Enable the WiLink6 connected to mmc2.
> > 
> > Signed-off-by: Imre Kaloz <kaloz@openwrt.org
> 
> Thanks applying into omap-for-v3.15/dt.

Oops, this breaks the build as WL12XX_REFCLOCK_24 is not defined
and I could not figure out what value it needs to be. Care to
repost this patch with WL12XX_REFCLOCK_24 also defined?

Regards,

Tony
