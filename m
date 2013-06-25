From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 25 Jun 2013 12:39:02 +0200
Subject: [PATCH 1/5] ARM: at91: at91_dt_defconfig: enable rm9200 support
In-Reply-To: <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51C97346.40209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 14:38, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/configs/at91_dt_defconfig |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 75fd842..690e892 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -14,11 +14,13 @@ CONFIG_MODULE_UNLOAD=y
>   # CONFIG_IOSCHED_DEADLINE is not set
>   # CONFIG_IOSCHED_CFQ is not set
>   CONFIG_ARCH_AT91=y
> +CONFIG_SOC_AT91RM9200=y
>   CONFIG_SOC_AT91SAM9260=y
>   CONFIG_SOC_AT91SAM9263=y
>   CONFIG_SOC_AT91SAM9G45=y
>   CONFIG_SOC_AT91SAM9X5=y
>   CONFIG_SOC_AT91SAM9N12=y
> +CONFIG_MACH_AT91RM9200_DT=y
>   CONFIG_MACH_AT91SAM9_DT=y
>   CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
>   CONFIG_AT91_TIMER_HZ=128
> @@ -62,6 +64,7 @@ CONFIG_MTD=y
>   CONFIG_MTD_CMDLINE_PARTS=y
>   CONFIG_MTD_CHAR=y
>   CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_DATAFLASH=y
>   CONFIG_MTD_NAND=y
>   CONFIG_MTD_NAND_ATMEL=y
>   CONFIG_MTD_UBI=y
> @@ -78,7 +81,6 @@ CONFIG_BLK_DEV_SD=y
>   CONFIG_SCSI_MULTI_LUN=y
>   # CONFIG_SCSI_LOWLEVEL is not set
>   CONFIG_NETDEVICES=y
> -CONFIG_MII=y

What is the reason for this change? It is really related with rm9200 DT 
suppot?

>   CONFIG_MACB=y
>   # CONFIG_NET_VENDOR_BROADCOM is not set
>   # CONFIG_NET_VENDOR_FARADAY is not set
>


-- 
Nicolas Ferre
