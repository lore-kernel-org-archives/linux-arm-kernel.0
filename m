From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 16:55:12 +0100
Subject: [PATCH] ARM: dts: stm32: Fix HSE clock frequency for
 stm32h743i-disco board
In-Reply-To: <1516983819-6567-1-git-send-email-patrice.chotard@st.com>
References: <1516983819-6567-1-git-send-email-patrice.chotard@st.com>
Message-ID: <08bbd782-7311-5d0a-a4c6-90700f26793a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

On 01/26/2018 05:23 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> The HSE oscillator frequency was wrongly set to 125MHz instead of 25MHz.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/boot/dts/stm32h743i-disco.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32h743i-disco.dts b/arch/arm/boot/dts/stm32h743i-disco.dts
> index 79e841d94079..45e088c55741 100644
> --- a/arch/arm/boot/dts/stm32h743i-disco.dts
> +++ b/arch/arm/boot/dts/stm32h743i-disco.dts
> @@ -63,7 +63,7 @@
>   };
>   
>   &clk_hse {
> -	clock-frequency = <125000000>;
> +	clock-frequency = <25000000>;
>   };
>   
>   &usart2 {
> 

Applied on stm32-next.

thanks
alex
