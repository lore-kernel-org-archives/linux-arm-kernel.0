From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Nov 2011 10:06:22 +0100
Subject: [PATCH 0/2] imx fixes for next-20111122
Message-ID: <20111122090622.GC19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series fixes the build failures of the day for next-20111122.

Uwe Kleine-K?nig (2):
      ARM: imx/mm-imx3: conditionally compile i.MX31 and i.MX35 code
      ARM: imx: export imx_ioremap to allow modules to use ioremap

 arch/arm/mach-imx/mm-imx3.c |   58 +++++++++++++++++++++++--------------------
 arch/arm/plat-mxc/system.c  |    2 +
 2 files changed, 33 insertions(+), 27 deletions(-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
