From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Fri, 29 Oct 2010 00:27:35 +0200
Subject: [PATCH] ARM: imx: Fix GPIO_1_xx settings that are wrongly assumed
In-Reply-To: <20101028205945.GE31158@pengutronix.de>
References: <1288296137-1995-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101028205945.GE31158@pengutronix.de>
Message-ID: <4CC9F8D7.4070802@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 28/10/2010 22:59, Uwe Kleine-K?nig a ?crit :
 > Before b545d9ed1b92f169d0326afac091328be5e76620 the muxmode entries were
 > correct.  Back when I looked at the patch that resulted into b545d9ed1b9
 > I wondered if the intended change was only
 > s/NO_PAD_CTRL/MX51_GPIO_PAD_CTRL/ but didn't check the reference manual.
 >
 > Eric?
 >
GPIO_PAD_CTRL was the original wanted change for that patch and while looking 
at this I misread the iomux pages in the manual for gpio 2 to 9 which leads to 
the mux error.

BTW, Arnaud Patard already provided a fix to this in it's efikamx patch serie.

Eric
