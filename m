From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 12 Aug 2014 09:00:30 +0800
Subject: [PATCH 2/4] ARM: rockchip: enable the AMBA bus
In-Reply-To: <1406661128-7614-3-git-send-email-heiko@sntech.de>
References: <1406661128-7614-1-git-send-email-heiko@sntech.de>
 <1406661128-7614-3-git-send-email-heiko@sntech.de>
Message-ID: <53E9672E.3090708@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/30/2014 03:12 AM, Heiko Stuebner wrote:
> This is needed to access the pl330 dma controllers on Rockchip SoCs.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index d168669..ac5803c 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -4,6 +4,7 @@ config ARCH_ROCKCHIP
>   	select PINCTRL_ROCKCHIP
>   	select ARCH_HAS_RESET_CONTROLLER
>   	select ARCH_REQUIRE_GPIOLIB
> +	select ARM_AMBA
>   	select ARM_GIC
>   	select CACHE_L2X0
>   	select HAVE_ARM_ARCH_TIMER
Tested-by: Kever Yang <kever.yang@rock-chips.com>
