From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 May 2014 12:33:03 +0300
Subject: [PATCH 1/2] ARM: dts: omap5-clocks.dtsi: add ti,set-rate-parent
 to dss_dss_clk
In-Reply-To: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
References: <1400674571-633-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <537F15CF.9060607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2014 03:16 PM, Tomi Valkeinen wrote:
> Add ti,set-rate-parent to dss_dss_clk so that the DSS driver can
> set the rate.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Both patches queued for 3.16, thanks.

-Tero

> ---
>   arch/arm/boot/dts/omap54xx-clocks.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> index d487fdab3921..d44bdaa8fe68 100644
> --- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
> @@ -851,6 +851,7 @@
>   		clocks = <&dpll_per_h12x2_ck>;
>   		ti,bit-shift = <8>;
>   		reg = <0x1420>;
> +		ti,set-rate-parent;
>   	};
>
>   	dss_sys_clk: dss_sys_clk {
>
