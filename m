From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 23 May 2017 15:59:39 +0200
Subject: [PATCH v3 5/5] ARM: dts: stm32: enable CRC32 on stm32429i-eval
 board
In-Reply-To: <2819bf67e93e583229741b7f5f838fba85d41e33.1495463449.git.cosardindar@gmail.com>
References: <cover.1495463449.git.cosardindar@gmail.com>
 <2819bf67e93e583229741b7f5f838fba85d41e33.1495463449.git.cosardindar@gmail.com>
Message-ID: <eb66d194-ffbb-bf99-8af4-591790a4d83c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/22/2017 04:35 PM, Cosar Dindar wrote:
> Enable the CRC32 crypto on stm32429i-eval board.
>
> Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
> ---

Will be applied in STM32 branch for next pull request.

Thanks
Alex

>  arch/arm/boot/dts/stm32429i-eval.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index b633114..360fb19 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -141,6 +141,10 @@
>  	clock-frequency = <25000000>;
>  };
>
> +&crc {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	pinctrl-0 = <&i2c1_pins>;
>  	pinctrl-names = "default";
>
