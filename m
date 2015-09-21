From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 21 Sep 2015 08:04:29 -0700
Subject: [PATCH 2/6] watchdog: Add support for Freescale Layerscape
 platforms
In-Reply-To: <1442838158-2964-3-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-3-git-send-email-B48286@freescale.com>
Message-ID: <56001C7D.4050408@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2015 05:22 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
"Enable IMX2+ watchdog for Layerscape platforms" would be a better
description.

Nitpick, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c68edc1..2862219 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
>
>   config IMX2_WDT
>   	tristate "IMX2+ Watchdog"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>   	select REGMAP_MMIO
>   	select WATCHDOG_CORE
>   	help
>
