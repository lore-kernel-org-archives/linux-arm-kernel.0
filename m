From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 08 Jan 2014 01:20:09 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7791: Add thermal clock in device
 tree
In-Reply-To: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
Message-ID: <1628481.pNd8Ov6MRK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 07 January 2014 19:57:13 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Add the missing thermal MSTP clock to the thermal device node.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index d8dbf7e7b6a9..3233041d8a44 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -151,6 +151,7 @@
>  		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
>  	};
> 
>  	timer {
-- 
Regards,

Laurent Pinchart
