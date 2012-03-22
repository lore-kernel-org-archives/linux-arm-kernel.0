From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 22 Mar 2012 15:52:13 +0100
Subject: [PATCH 3/4] arm: at91: dt: sam9x5 add mci support
In-Reply-To: <1332352994-20983-4-git-send-email-ludovic.desroches@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 <1332352994-20983-4-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4F6B3C9D.60300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 07:03 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index c111001..5846f99 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -191,6 +191,20 @@
>  				interrupts = <27 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc at f0008000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf0008000 0x600>;
> +				interrupts = <12 4>;
> +				status = "disabled";
> +			};
> +
> +			mmc1: mmc at f000c000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf000c000 0x600>;
> +				interrupts = <26 4>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		nand0: nand at 40000000 {


-- 
Nicolas Ferre
