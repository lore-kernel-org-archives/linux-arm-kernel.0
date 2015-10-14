From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 14 Oct 2015 15:38:33 +0200
Subject: [PATCH v4 2/3] arm64: mediatek: enable MTK_TIMER
In-Reply-To: <1443798319-45744-3-git-send-email-yingjoe.chen@mediatek.com>
References: <1443798319-45744-1-git-send-email-yingjoe.chen@mediatek.com>
 <1443798319-45744-3-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <561E5AD9.1000803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/15 17:05, Yingjoe Chen wrote:
> Enable MTK_TIMER for MediaTek plaform, which will be used as
> tick broadcast device and schedule clock.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---

I reapplied this on v4.4-next/soc

>   arch/arm64/Kconfig.platforms | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 23800a1..8176455 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -42,6 +42,7 @@ config ARCH_MEDIATEK
>   	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
>   	select ARM_GIC
>   	select PINCTRL
> +	select MTK_TIMER
>   	help
>   	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
>
>
