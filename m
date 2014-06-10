From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Jun 2014 14:27:50 +0200
Subject: [PATCH v2 5/5] ARM: atmel: at91sam9n12ek: switch sound to CCF
In-Reply-To: <1402284707-23354-6-git-send-email-voice.shen@atmel.com>
References: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
 <1402284707-23354-6-git-send-email-voice.shen@atmel.com>
Message-ID: <5396F9C6.2050901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2014 05:31, Bo Shen :
> As the at91sam9n12ek has switch to CCF, so add clock for wm8904
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> Reviwed-by: Mark Brown <broonie@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

> ---
> Changes in v2:
>   - None
> 
>  arch/arm/boot/dts/at91sam9n12ek.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index 64bbe46..8ae771d 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -56,6 +56,8 @@
>  				wm8904: codec at 1a {
>  					compatible = "wm8904";
>  					reg = <0x1a>;
> +					clocks = <&pck0>;
> +					clock-names = "mclk";
>  				};
>  
>  				qt1070: keyboard at 1b {
> 


-- 
Nicolas Ferre
