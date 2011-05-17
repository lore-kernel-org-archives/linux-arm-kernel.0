From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 17 May 2011 17:04:41 +0200
Subject: [PATCH 0/6] drop IRQF_DISABLED from RTC, then convert stmp-rtc
	to mach-mxs
In-Reply-To: <20110517142730.GA25472@S2100-06.ap.freescale.net>
References: <1304590941-11813-1-git-send-email-w.sang@pengutronix.de>
	<20110517142730.GA25472@S2100-06.ap.freescale.net>
Message-ID: <20110517150441.GD2200@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> > First, cleanup RTC to remove the deprecated IRQF_DISABLED which is a
> > nop these days.
> > 
> > Then, because plat-stmp is going to be removed and merged with mxs, this
> > patch series will convert the stmp-rtc driver for usage with mach-mxs.
> > Quite some platform-specific dependencies have been removed, so the
> > driver should be better reusable.
> > 
> > The driver has successfully been tested on an i.MX28-board and passed the RTC
> > test program.
> > 
> Can you post the platform device code?  I would give it a test on my end.

Yup, will send them as RFC in a minute. Tests are much appreciated, thanks!
Would add the tags then to V2 of this series (with updated commit msgs)
when you are done.

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110517/93db441a/attachment.sig>
