From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Mar 2010 09:43:07 +0100
Subject: [PATCH 3/3] imx31: add watchdog device on litekit board.
In-Reply-To: <1269011819-23257-1-git-send-email-vzapolskiy@gmail.com>
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
	<1269011819-23257-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100322084307.GI2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 06:16:59PM +0300, Vladimir Zapolskiy wrote:
> This patch adds support for SoC build-in watchdog device on litekit
> board.

Added to mxc-master.

Sascha

> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/mx31lite-db.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
> index ccd8742..0201683 100644
> --- a/arch/arm/mach-mx3/mx31lite-db.c
> +++ b/arch/arm/mach-mx3/mx31lite-db.c
> @@ -206,5 +206,6 @@ void __init mx31lite_db_init(void)
>  	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
>  	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
>  	platform_device_register(&litekit_led_device);
> +	mxc_register_device(&imx_wdt_device0, NULL);
>  }
>  
> -- 
> 1.6.6.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
