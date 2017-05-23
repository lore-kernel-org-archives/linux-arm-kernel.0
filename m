From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 23 May 2017 15:59:29 +0200
Subject: [PATCH v3 4/5] ARM: dts: stm32: enable CRC32 on stm32429-disco
 board
In-Reply-To: <43babcf91eb49c5dffc4164b87839eeb537f0ee1.1495463449.git.cosardindar@gmail.com>
References: <cover.1495463449.git.cosardindar@gmail.com>
 <43babcf91eb49c5dffc4164b87839eeb537f0ee1.1495463449.git.cosardindar@gmail.com>
Message-ID: <d1a3a862-715f-f440-e25b-38cc5ddbad09@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/22/2017 04:34 PM, Cosar Dindar wrote:
> Enable the CRC32 crypto on stm32429-disco board.
>
> Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
> ---


Will be applied in STM32 branch for next pull request.

Thanks
Alex

>  arch/arm/boot/dts/stm32f429-disco.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
> index 191fa50..ae47cde 100644
> --- a/arch/arm/boot/dts/stm32f429-disco.dts
> +++ b/arch/arm/boot/dts/stm32f429-disco.dts
> @@ -102,6 +102,10 @@
>  	clock-frequency = <8000000>;
>  };
>
> +&crc {
> +	status = "okay";
> +};
> +
>  &rtc {
>  	assigned-clocks = <&rcc 1 CLK_RTC>;
>  	assigned-clock-parents = <&rcc 1 CLK_LSI>;
>
