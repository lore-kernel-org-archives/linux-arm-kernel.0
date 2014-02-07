From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Feb 2014 16:49:14 +0100
Subject: [PATCH] ARM: at91: enable USB host on at91sam9n12ek board
In-Reply-To: <1389681284-28833-1-git-send-email-voice.shen@atmel.com>
References: <1389681284-28833-1-git-send-email-voice.shen@atmel.com>
Message-ID: <52F5007A.4090203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/2014 07:34, Bo Shen :
> Enable USB host on at91sam9n12ek board.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Added to at91-3.14-fixes because there is no benefit in keeping it
outside of mainline for a longer time.

Bye,


> ---
>  arch/arm/boot/dts/at91sam9n12ek.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index e9487f6..924a6a6 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -124,6 +124,10 @@
>  			nand-on-flash-bbt;
>  			status = "okay";
>  		};
> +
> +		usb0: ohci at 00500000 {
> +			status = "okay";
> +		};
>  	};
>  
>  	leds {
> 


-- 
Nicolas Ferre
