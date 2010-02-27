From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 27 Feb 2010 21:33:45 +0100
Subject: arch/arm broken in next
Message-ID: <20100227203345.GA5760@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

since

	40464e5 (Merge remote branch 'samsung/next-samsung')

next is broken for arch/arm.  Our autobuilders fail with:

	arch/arm/Kconfig:920: file 'arch/arm/mach-lh7a40x/Kconfig' is already sourced from 'arch/arm/Kconfig'

Both parents of 40464e5 only include the above file once.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
