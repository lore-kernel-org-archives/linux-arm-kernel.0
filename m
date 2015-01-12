From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 14:21:13 +0100
Subject: [PATCH] ARM: at91: sama5d3: dt: correct the sound route
In-Reply-To: <1420795096-8944-1-git-send-email-voice.shen@atmel.com>
References: <1420795096-8944-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54B3CA49.7010302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/01/2015 10:18, Bo Shen a ?crit :
> The MICBIAS is a supply, should route to MIC while not IN1L.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I stack it up in at91-3.19-fixes.

Thanks. Bye.


> ---
> 
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index 0399be6..83d0598 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -176,7 +176,7 @@
>  			"Headphone Jack", "HPOUTR",
>  			"IN2L", "Line In Jack",
>  			"IN2R", "Line In Jack",
> -			"MICBIAS", "IN1L",
> +			"Mic", "MICBIAS",
>  			"IN1L", "Mic";
>  
>  		atmel,ssc-controller = <&ssc0>;
> 


-- 
Nicolas Ferre
