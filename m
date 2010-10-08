From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Oct 2010 15:43:36 +0200
Subject: imx-for-2.6.37 broken [Was: [PATCH 2/4] eukrea_mbimxsd for
	cpuimx35: add CAN & SDCard support]
In-Reply-To: <1286032529-26509-2-git-send-email-eric@eukrea.com>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
	<1286032529-26509-2-git-send-email-eric@eukrea.com>
Message-ID: <20101008134336.GJ29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei Sascha,

you took this patch (patches 3 and 4, too) for your 2.6.37 branch
without taking the dependencies (i.e. Wolfram's Patches that add the
functions to register ehci devices.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
