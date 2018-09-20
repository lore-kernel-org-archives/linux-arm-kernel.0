From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 20 Sep 2018 17:50:33 +0200
Subject: [PATCH] ARM: dts: stm32: update SPI6 dmas property on stm32mp157c
In-Reply-To: <1537171487-15191-1-git-send-email-amelie.delaunay@st.com>
References: <1537171487-15191-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1efc3bad-cea0-95c4-078d-67463f2b9e6d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Am?lie

On 09/17/2018 10:04 AM, Amelie Delaunay wrote:
> Remove unused parameter from SPI6 dmas property on stm32mp157c SoC.
> 
> Fixes: dc3f8c86c10d ("ARM: dts: stm32: add SPI support on stm32mp157c")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 661be94..185541a 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -1078,8 +1078,8 @@
>   			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&rcc SPI6_K>;
>   			resets = <&rcc SPI6_R>;
> -			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0 0>,
> -			       <&mdma1 35 0x0 0x40002 0x0 0x0 0>;
> +			dmas = <&mdma1 34 0x0 0x40008 0x0 0x0>,
> +			       <&mdma1 35 0x0 0x40002 0x0 0x0>;
>   			dma-names = "rx", "tx";
>   			status = "disabled";
>   		};
> 

Applied on stm32-next.

Thanks.
Alex
