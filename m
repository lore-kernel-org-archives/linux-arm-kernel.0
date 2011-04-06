From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Apr 2011 20:41:21 +0200
Subject: [PATCH] ARM: mx51: Remove imx51_add_gpio_keys
In-Reply-To: <1302105926-20574-1-git-send-email-fabio.estevam@freescale.com>
References: <1302105926-20574-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110406184121.GJ13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 01:05:26PM -0300, Fabio Estevam wrote:
> There is no need for using a MX51-specific version of imx_add_gpio_keys.
> 
> Remove imx51_add_gpio_keys and use imx_add_gpio_keys instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Nice, this was already on my mental todo list, too.

Thanks, I'll take it in my tree that I prepare for Sascha.
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
