From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 17:37:46 +0900
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
In-Reply-To: <20110710080450.GW29624@pengutronix.de>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
	<1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
	<20110710080450.GW29624@pengutronix.de>
Message-ID: <20110710083744.GD23199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 10:04:50AM +0200, Uwe Kleine-K?nig wrote:

> 	- mfd/mc13xxx: implicitly enable leds and buttons (and
> 	  regulators?)

It's nicer to enable regulators unconditionally, even if they're not
controlled by software in the system reading their state can still be
useful.
