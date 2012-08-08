From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 8 Aug 2012 10:59:56 +0200
Subject: [PATCH 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <20120803131230.GB23791@S2101-09.ap.freescale.net>
References: <1343922986-32469-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120803131230.GB23791@S2101-09.ap.freescale.net>
Message-ID: <20120808085956.GB25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Aug 03, 2012 at 09:12:32PM +0800, Shawn Guo wrote:
> On Thu, Aug 02, 2012 at 05:56:25PM +0200, Uwe Kleine-K?nig wrote:
> > +			gpio3: gpio at 0x53fa4000 {
> > +				compatible = "fsl,imx35-gpio", "fsl,imx31-gpio";
> 
> compatible = "fsl,imx35-gpio";
$ git grep fsl,imx3[15]-gpio drivers/gpio
drivers/gpio/gpio-mxc.c:        { .compatible = "fsl,imx31-gpio", .data = &mxc_gpio_devtype[IMX31_GPIO], },

I guess that means I have to keep "fsl,imx31-gpio", right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
