From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Apr 2014 22:50:06 +0200
Subject: [PATCH 4/8] ARM: at91: sama5d3: add the missing property
In-Reply-To: <1395049541-28128-5-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
 <1395049541-28128-5-git-send-email-voice.shen@atmel.com>
Message-ID: <53518FFE.5000305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/2014 10:45, Bo Shen :
> If without the MICBIAS routing, the record don't work.
> Add the missing MICBIAS routing to let record from mic working.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> 
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index e1bd5767..0600153 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -166,6 +166,7 @@
>  			"Headphone Jack", "HPOUTR",
>  			"IN2L", "Line In Jack",
>  			"IN2R", "Line In Jack",
> +			"MICBIAS", "IN1L",
>  			"IN1L", "Mic";
>  
>  		atmel,ssc-controller = <&ssc0>;
> 


-- 
Nicolas Ferre
