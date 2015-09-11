From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 19:03:06 +0100
Subject: [PATCH 01/11] ARM: STi: DT: STiH407: Add a cec0 pin definition
In-Reply-To: <1441991194-11948-2-git-send-email-peter.griffin@linaro.org>
References: <1441991194-11948-1-git-send-email-peter.griffin@linaro.org>
 <1441991194-11948-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150911180306.GQ18779@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Sep 2015, Peter Griffin wrote:

> This pin setup provides the correct configuration in order to
> interact with the CEC HW.
> 
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
> Signed-off-by: Nicolas Vanhaelewyn <nicolas.vanhaelewyn@st.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Duplicate.

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)

For the patch: Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index 0a754f2..d86ccc8 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -107,6 +107,14 @@
>  				st,retime-pin-mask = <0x3f>;
>  			};
>  
> +			cec0 {
> +				pinctrl_cec0_default: cec0-default {
> +					st,pins {
> +						hdmi_cec = <&pio2 4 ALT1 BIDIR>;
> +					};
> +				};
> +			};
> +
>  			rc {
>  				pinctrl_ir: ir0 {
>  					st,pins {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
