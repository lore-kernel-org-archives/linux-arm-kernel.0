From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 18 May 2011 10:37:02 +0800
Subject: [PATCH 0/6] drop IRQF_DISABLED from RTC, then convert stmp-rtc
	to mach-mxs
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110518023701.GA25710@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 12:22:15PM +0200, Wolfram Sang wrote:
> First, cleanup RTC to remove the deprecated IRQF_DISABLED which is a
> nop these days.
> 
> Then, because plat-stmp is going to be removed and merged with mxs, this
> patch series will convert the stmp-rtc driver for usage with mach-mxs.
> Quite some platform-specific dependencies have been removed, so the
> driver should be better reusable.
> 
> The driver has successfully been tested on an i.MX28-board and passed the RTC
> test program.
> 
> Regards,
> 
>    Wolfram
> 
> Wolfram Sang (6):
>   rtc: remove IRQF_DISABLED
>   rtc: stmp3xxx: get rid of platform-specific register include
>   rtc: stmp3xxx: port stmp-functions to mxs-equivalents
>   rtc: stmp3xxx: fix crash on boot
>   rtc: stmp3xxx: get rid of mach-specific accessors
>   rtc: stmp3xxx: remove UIE handlers
> 
On i.MX23 and i.MX28

Tested-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn
