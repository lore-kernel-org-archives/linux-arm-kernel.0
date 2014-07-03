From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Jul 2014 19:57:02 +0200
Subject: [PATCH] ARM: imx: imx6sx uses imx6q cpuidle code
In-Reply-To: <6439884.YMH7C85FhG@wuerfel>
References: <6439884.YMH7C85FhG@wuerfel>
Message-ID: <20140703175702.GV14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Thu, Jul 03, 2014 at 04:16:06PM +0200, Arnd Bergmann wrote:
>  obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
>  obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
>  obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
> +obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6q.o
as this line looks wrong it might be worth a comment ...

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
