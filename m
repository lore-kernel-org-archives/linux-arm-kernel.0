From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 May 2011 22:27:31 +0800
Subject: [PATCH 0/6] drop IRQF_DISABLED from RTC, then convert stmp-rtc
	to mach-mxs
In-Reply-To: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110517142730.GA25472@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

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
Can you post the platform device code?  I would give it a test on my end.

-- 
Regards,
Shawn
