From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 15 Oct 2015 07:25:19 -0700
Subject: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape
 platforms
In-Reply-To: <1444911181-21696-2-git-send-email-B48286@freescale.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-2-git-send-email-B48286@freescale.com>
Message-ID: <561FB74F.5000302@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 05:12 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
> This patch has been acked in V3 by Guenter Roeck [linux at roeck-us.net].
>
Here it is again, but if there is no change, please just add the Ack
to subsequent versions of the patch.

Acked-by: Guenter Roeck <linux@roeck-us.net>


> V4: V3 V2
>   - No change.
>
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..448dbaf 100644
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
