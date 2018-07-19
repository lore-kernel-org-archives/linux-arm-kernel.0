From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Thu, 19 Jul 2018 13:27:56 +0000
Subject: [U-BOOT internal] ARM: dts: stm32: Add clk-lse node's label on
 stm32f429
In-Reply-To: <1532005842-3264-1-git-send-email-patrice.chotard@st.com>
References: <1532005842-3264-1-git-send-email-patrice.chotard@st.com>
Message-ID: <a4472301-1394-3680-079d-b7eab8a6a917@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, don't take care about this patch, it was send using the wrong script

Patrice

On 07/19/2018 03:10 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Add missing clk_lse label for node clk-lse.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/boot/dts/stm32f429.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index ede77e0f1c41..64278e81bc08 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -58,7 +58,7 @@
>   			clock-frequency = <0>;
>   		};
>   
> -		clk-lse {
> +		clk_lse: clk-lse {
>   			#clock-cells = <0>;
>   			compatible = "fixed-clock";
>   			clock-frequency = <32768>;
> 
