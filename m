From: timur@freescale.com (Timur Tabi)
Date: Sat, 28 Nov 2009 16:00:47 -0600
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <20091123121321.GF30179@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
	<20091123120000.GC24326@rakim.wolfsonmicro.main>
	<20091123121321.GF30179@pengutronix.de>
Message-ID: <4B119D8F.3030509@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
>> while the PowerPC one
>> >  is including asm/immap_86xx.h for something.
> This include seems unused. Timur, can you confirm this?

I can confirm that immap_86xx.h is *not* needed for fsl_ssi.c.  When I update 
the driver for the P1022, I'll remove it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
