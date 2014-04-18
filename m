From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 22:50:17 +0200
Subject: [PATCH 5/8] ARM: at91: sama5d3: clock for ssc from rk pin
In-Reply-To: <1395049541-28128-6-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
 <1395049541-28128-6-git-send-email-voice.shen@atmel.com>
Message-ID: <53519009.8040405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2014 10:45, Bo Shen :
> According to hardware design the clock for SSC device is from rk pin.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> 
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index 0600153..306eef0 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -32,6 +32,10 @@
>  				};
>  			};
>  
> +			ssc0: ssc at f0008000 {
> +				atmel,clk-from-rk-pin;
> +			};
> +
>  			/*
>  			 * i2c0 conflicts with ISI:
>  			 * disable it to allow the use of ISI
> 


-- 
Nicolas Ferre
