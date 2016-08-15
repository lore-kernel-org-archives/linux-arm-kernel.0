From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Aug 2016 07:30:33 +0200
Subject: [PATCH] ARM: dts: imx6q-bx50v3: configure unused pca953x pins
In-Reply-To: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
References: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <20160815053033.ds27jg3c7vnx7ujw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Aug 12, 2016 at 01:45:11PM -0400, Akshay Bhat wrote:
> At power on, pca953x GPIO pins are configured as input and may cause
> unexpected interrupts. Configure the unused pins as GPO low to
> avoid unexpected interrupts.

Is this really about irqs? There should be no irqs for lines where no
irq is requested. Can you describe the problem in more detail?

Bst regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
