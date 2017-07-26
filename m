From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 26 Jul 2017 18:23:23 +0200
Subject: [PATCH 2/2] arm: dts: stm32: enable cec for stm32f769 discovery
In-Reply-To: <1500366141-30706-2-git-send-email-benjamin.gaignard@linaro.org>
References: <1500366141-30706-1-git-send-email-benjamin.gaignard@linaro.org>
 <1500366141-30706-2-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <39dfcc52-3c31-975e-387b-83284e9c9437@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 07/18/2017 10:22 AM, Benjamin Gaignard wrote:
> enable cec for stm32f769 discovery board
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 166728a..14e54da 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -72,3 +72,9 @@
>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> +
> +&cec {
> +	pinctrl-0 = <&cec_pins_a>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> 
After minor changes, applied on stm32-dt-for-v4.14 branch.

Thanks
Alex
