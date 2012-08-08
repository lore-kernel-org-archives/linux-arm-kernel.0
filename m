From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 Aug 2012 22:43:39 +0800
Subject: [PATCH 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <20120808085956.GB25520@pengutronix.de>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120803131230.GB23791@S2101-09.ap.freescale.net>
 <20120808085956.GB25520@pengutronix.de>
Message-ID: <20120808144337.GD14718@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 10:59:56AM +0200, Uwe Kleine-K?nig wrote:
> $ git grep fsl,imx3[15]-gpio drivers/gpio
> drivers/gpio/gpio-mxc.c:        { .compatible = "fsl,imx31-gpio", .data = &mxc_gpio_devtype[IMX31_GPIO], },
> 
Try it on v3.6-rc1.

-- 
Regards,
Shawn
