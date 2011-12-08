From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Dec 2011 23:55:53 +0100
Subject: [PATCH] [RFC] pinctrl: add a driver for Energy Micro's efm32 SoCs
In-Reply-To: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323384057-31452-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4693507.K6tP4YDUh2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 December 2011 23:40:57 Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Note that there is no support yet for efm32 in mainline, so ARCH_EFM32
> isn't defined.

Since the platform is not yet part of the architecture, it will have
to use device tree based probing when it gets added. I would suggest
only merging drivers for it that can deal with this and do not rely
on platform_data.

Other than that, the driver looks ok to me.

	Arnd
