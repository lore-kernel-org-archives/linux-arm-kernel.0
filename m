From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 20 Oct 2017 13:13:55 +0200
Subject: [PATCH] arm64: mediatek: cleanup message for platform selection
In-Reply-To: <82b4e4301bb762af59fd76cfe15f0a5773c78bb3.1508406417.git.sean.wang@mediatek.com>
References: <82b4e4301bb762af59fd76cfe15f0a5773c78bb3.1508406417.git.sean.wang@mediatek.com>
Message-ID: <0f9cfd78-17e4-9523-2c6e-1cf0960e6506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2017 11:52 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> The latest kernel tree already can support more MediaTek platforms such as
> MT2712 and MT7622, so additional descriptions for those platforms are added
> and certain cleanups are also being made here.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

pushed to the soc branch, thanks.

>  arch/arm64/Kconfig.platforms | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6b54ee8..ab69f5f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -91,12 +91,13 @@ config ARCH_HISI
>  	  This enables support for Hisilicon ARMv8 SoC family
>  
>  config ARCH_MEDIATEK
> -	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
> +	bool "MediaTek SoC Family"
>  	select ARM_GIC
>  	select PINCTRL
>  	select MTK_TIMER
>  	help
> -	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
> +	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
> +	  & MT81xx ARMv8 SoCs
>  
>  config ARCH_MESON
>  	bool "Amlogic Platforms"
> 
