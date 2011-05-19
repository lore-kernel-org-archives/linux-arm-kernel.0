From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 May 2011 19:05:48 +0200
Subject: [PATCH v2 0/7] Consolidate sdhci pltfm & OF drivers and get them
	self registered
In-Reply-To: <20110519160901.GC26816@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<20110519094046.GA2219@pengutronix.de>
	<20110519160901.GC26816@S2100-06.ap.freescale.net>
Message-ID: <20110519170548.GA1075@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> Should I go for v3 right now to address the patch applying problems
> and that ESDHC_IMX build issue, or hold for a while to see if you
> have more comments on v2?

Please wait a little bit more.

> And what is your position on patch #5 which merges esdhc imx and mpc
> support into one?  As Anton has voted a NO there, I would probably
> drop the patch if there is another person has strong opinion to get
> imx and mpc stay separated.

This was the other main issue I spotted so far. I wanted to have another look
tomorrow, yet the tendency is that I agree with Anton.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/06e7724f/attachment-0001.sig>
