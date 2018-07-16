From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 16 Jul 2018 15:55:44 +0200
Subject: [PATCH 2/2] arm64: dts: mt7622: update a clock property for UART0
In-Reply-To: <b96deaa9f54a0ae3f62ec30d858be7abd1ed873f.1531209126.git.ryder.lee@mediatek.com>
References: <2ff39c40ef6bc3054667e63c785a1d28527b5ddf.1531209126.git.ryder.lee@mediatek.com>
 <b96deaa9f54a0ae3f62ec30d858be7abd1ed873f.1531209126.git.ryder.lee@mediatek.com>
Message-ID: <a4f0c6db-b88f-4c54-827a-e160bebae62b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryder,

On 10/07/18 09:55, Ryder Lee wrote:
> The input clock of UART0 should be CLK_PERI_UART0_PD.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Can you provide a "Fixes" tag with the commit id of the commit that broke this?

Thanks,
Matthias

> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 8cdec52..4caa9b4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -367,7 +367,7 @@
>  		reg = <0 0x11002000 0 0x400>;
>  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&topckgen CLK_TOP_UART_SEL>,
> -			 <&pericfg CLK_PERI_UART1_PD>;
> +			 <&pericfg CLK_PERI_UART0_PD>;
>  		clock-names = "baud", "bus";
>  		status = "disabled";
>  	};
> 
