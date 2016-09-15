From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 15 Sep 2016 09:47:32 +0200
Subject: [PATCH v3 10/14] ARM: DT: STiH407: Enable synchronous clock mode
 for video clocks
In-Reply-To: <1472473626-15398-11-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
 <1472473626-15398-11-git-send-email-gabriel.fernandez@st.com>
Message-ID: <bf808310-1b77-0914-991a-fb8ac6a97718@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2016 02:27 PM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch enables the synchronous clock mode for video clocks
> on STiH407 board.
> 
> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Acked-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index c4a8f1c..13029c0 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -256,7 +256,7 @@
>  
>  			clk_s_d2_flexgen: clk-s-d2-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen";
> +				compatible = "st,flexgen-video", "st,flexgen";
>  
>  				clocks = <&clk_s_d2_quadfs 0>,
>  					 <&clk_s_d2_quadfs 1>,
> 
Hi Gabriel

Applied on STi tree for v4.9

Thanks
