From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 17:00:53 +0100
Subject: [PATCH] ARM: dts: stm32: enable RTC on stm32f769-disco
In-Reply-To: <1518788832-21714-1-git-send-email-amelie.delaunay@st.com>
References: <1518788832-21714-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <b4e88f63-f48b-8333-ca79-0d6f1617a449@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie

On 02/16/2018 02:47 PM, Amelie Delaunay wrote:
> This patch enables RTC on stm32f769-disco.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32f769-disco.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 4463ca1..48cb47f 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -73,6 +73,10 @@
>   	clock-frequency = <25000000>;
>   };
>   
> +&rtc {
> +	status = "okay";
> +};
> +
>   &usart1 {
>   	pinctrl-0 = <&usart1_pins_a>;
>   	pinctrl-names = "default";
> 

Applied on stm32-next.

Thanks.
Alex
