From: wim@iguana.be (Wim Van Sebroeck)
Date: Mon, 10 Jan 2011 14:21:15 +0100
Subject: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
In-Reply-To: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
References: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110110132115.GM3801@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 8a3aa2f..0981aae 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -331,6 +331,15 @@ config IMX2_WDT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called imx2_wdt.
>  
> +config DW_WATCHDOG
> +	tristate "Synopsys DesignWare watchdog"
> +        select WATCHDOG_NOWAYOUT
> +	help
> +	  Say Y here if to include support for the Synopsys DesignWare
> +	  watchdog timer found in many ARM chips.
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dw_wdt.
> +
>  # AVR32 Architecture
>  
>  config AT32AP700X_WDT

Could you add the correct dependancy also in Kconfig?

Thanks in advance,
Wim.
