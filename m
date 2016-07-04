From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 4 Jul 2016 10:25:46 +0200
Subject: [PATCH] ARM: defconfig/at91: Add Bosch M_CAN driver
In-Reply-To: <1467616514-23589-1-git-send-email-wenyou.yang@atmel.com>
References: <1467616514-23589-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <577A1D8A.8080108@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/07/2016 09:15, Wenyou Yang a ?crit :
> Add CONFIG_CAN_M_CAN=y option to enable Bosch M_CAN device driver.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

It seems not present in multi_v7 as well: can you please add it as a module?

Bye,

> ---
> 
>  arch/arm/configs/sama5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 9cb1a85..dcde44ff 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -52,6 +52,7 @@ CONFIG_IP_PNP_RARP=y
>  CONFIG_IPV6_SIT_6RD=y
>  CONFIG_CAN=y
>  CONFIG_CAN_AT91=y
> +CONFIG_CAN_M_CAN=y
>  CONFIG_CFG80211=y
>  CONFIG_MAC80211=y
>  CONFIG_MAC80211_LEDS=y
> 


-- 
Nicolas Ferre
