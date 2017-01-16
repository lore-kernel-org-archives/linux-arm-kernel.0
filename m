From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 15:40:00 +0100
Subject: [PATCHv3 RESEND 7/8] ARM: dts: stm32: enable RTC on stm32429i-eval
In-Reply-To: <1484573388-590-5-git-send-email-amelie.delaunay@st.com>
References: <1484573388-590-1-git-send-email-amelie.delaunay@st.com>
 <1484573388-590-5-git-send-email-amelie.delaunay@st.com>
Message-ID: <289c63f8-08d0-20b7-b884-28d4fd0abed6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/16/2017 02:29 PM, Amelie Delaunay wrote:
> This patch enables RTC on stm32429i-eval with default LSE clock source.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 2181220..eedb27d 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -157,6 +157,10 @@
>  	};
>  };
>
> +&rtc {
> +	status = "okay";
> +};
> +
>  &usart1 {
>  	pinctrl-0 = <&usart1_pins_a>;
>  	pinctrl-names = "default";
>
Applied on stm32-dt-for-v4.11

Thanks
Alex
