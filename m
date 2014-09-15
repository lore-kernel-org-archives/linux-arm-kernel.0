From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 15 Sep 2014 11:18:26 +0200
Subject: [PATCHv2 7/8] ARM: at91: add sama5d4 support to sama5_defconfig
In-Reply-To: <1410536587-24607-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410536587-24607-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410536587-24607-8-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5416AEE2.4070303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2014 17:43, Alexandre Belloni :
> Add sama5d4 to sama5_defconfig to build kernel booting on both sama5d3 and
> samad4.
> 
> Note that earlyprintk can only be working for one or the other.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 96c15b775d57..c9089c927daf 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -19,6 +19,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
>  CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAM_V7=y
>  CONFIG_SOC_SAMA5D3=y
> +CONFIG_SOC_SAMA5D4=y
>  CONFIG_MACH_SAMA5_DT=y
>  CONFIG_AEABI=y
>  CONFIG_UACCESS_WITH_MEMCPY=y
> 


-- 
Nicolas Ferre
