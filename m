From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 2 Sep 2014 11:14:31 +0200
Subject: [PATCH v2 4/4] dts: atmel: at91sam9g20: switch ssc compatible
 string
In-Reply-To: <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
References: <1402481682-9811-1-git-send-email-voice.shen@atmel.com>
 <1402481682-9811-5-git-send-email-voice.shen@atmel.com>
Message-ID: <54058A77.3090603@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2014 12:14, Bo Shen :
> As the SSC integrate in at91sam9g20 support frame sync length
> extension, so switch compatible string to support this feature.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Now that the audio part is included, I take the DT for at91-3.18-dt3:
thanks!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
> Changes in v2:
>   - New
> 
>  arch/arm/boot/dts/at91sam9g20.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index b8e7946..dcd39fe 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -22,6 +22,10 @@
>  				compatible = "atmel,at91sam9g20-i2c";
>  			};
>  
> +			ssc0: ssc at fffbc000 {
> +				compatible = "atmel,at91sam9rl-ssc";
> +			};
> +
>  			adc0: adc at fffe0000 {
>  				atmel,adc-startup-time = <40>;
>  			};
> 


-- 
Nicolas Ferre
