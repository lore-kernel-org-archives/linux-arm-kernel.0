From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 14:00:45 +0200
Subject: [PATCH v9 12/19] ARM: DT: STiH407: Add spdif_out pinctrl config
In-Reply-To: <1473081421-16555-13-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-13-git-send-email-peter.griffin@linaro.org>
Message-ID: <d05117cc-cccf-b39d-cd25-d9aa182e3f31@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

On 09/05/2016 03:16 PM, Peter Griffin wrote:
> This patch adds the pinctrl config for the spidf out
> pins used by the sasg codec IP.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index 537db7e..598dbab 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -1114,6 +1114,14 @@
>  				};
>  			};
>  
> +			spdif_out {
> +				pinctrl_spdif_out: spdif_out{
> +					st,pins {
> +						spdif_out = <&pio34 7 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
>  			serial3 {
>  				pinctrl_serial3: serial3-0 {
>  					st,pins {
> 



Applied for STi next

Thanks
