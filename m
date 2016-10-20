From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Oct 2016 17:34:21 +0100
Subject: [PATCH v2 6/9] ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
In-Reply-To: <1476890480-8884-7-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-7-git-send-email-jbrunet@baylibre.com>
Message-ID: <c480f84f-ffc8-69fd-1dad-30cd2eb3360b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/16 16:21, Jerome Brunet wrote:
> Add select MESON_IRQ_GPIO in Kconfig for Amlogic's meson SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index cfbdf02ef566..846479d4492d 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -95,6 +95,7 @@ config ARCH_MESON
>  	select PINCTRL_MESON
>  	select COMMON_CLK_AMLOGIC
>  	select COMMON_CLK_GXBB
> +	select MESON_GPIO_IRQ

MESON_IRQ_GPIO?

>  	help
>  	  This enables support for the Amlogic S905 SoCs.
>  
> 


-- 
Jazz is not dead. It just smells funny...
