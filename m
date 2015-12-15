From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 15 Dec 2015 11:13:38 +0100
Subject: [PATCH] ARM: at91/sama5_defconfig: enable watchdog driver
In-Reply-To: <1446709076-24359-1-git-send-email-wenyou.yang@atmel.com>
References: <1446709076-24359-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <566FE7D2.4080201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/11/2015 08:37, Wenyou Yang a ?crit :
> Enabel AT91SAM9X / AT91CAP9 watchdog and SAMA5D4 watchdog.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on top of at91-4.5-dt.

Thanks!


> ---
> 
>  arch/arm/configs/sama5_defconfig |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index a0c57ac..963daae 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -130,6 +130,9 @@ CONFIG_POWER_SUPPLY=y
>  CONFIG_POWER_RESET=y
>  # CONFIG_HWMON is not set
>  CONFIG_SSB=m
> +CONFIG_WATCHDOG=y
> +CONFIG_AT91SAM9X_WATCHDOG=y
> +CONFIG_SAMA5D4_WATCHDOG=y
>  CONFIG_MFD_ATMEL_FLEXCOM=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> 


-- 
Nicolas Ferre
