From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 19 Jun 2014 14:10:36 +0300
Subject: [PATCH v2 06/18] ARM: dts: DRA7: Add divider table to
 optfclk_pciephy_div clock
In-Reply-To: <1401345500-20188-7-git-send-email-kishon@ti.com>
References: <1401345500-20188-1-git-send-email-kishon@ti.com>
 <1401345500-20188-7-git-send-email-kishon@ti.com>
Message-ID: <53A2C52C.6020606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2014 09:38 AM, Kishon Vijay Abraham I wrote:
> From: Keerthy <j-keerthy@ti.com>
>
> Add divider table to optfclk_pciephy_div clock. The Documentation
> for divider clock can be found at ../clock/ti/divider.txt

This patch requires a better changelog. Why is the change done, any TRM 
refs etc.?

-Tero

>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/dra7xx-clocks.dtsi |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index c767687..55e95c5 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1170,6 +1170,7 @@
>   		clocks = <&apll_pcie_ck>;
>   		#clock-cells = <0>;
>   		reg = <0x021c>;
> +		ti,dividers = <2>, <1>;
>   		ti,bit-shift = <8>;
>   		ti,max-div = <2>;
>   	};
>
