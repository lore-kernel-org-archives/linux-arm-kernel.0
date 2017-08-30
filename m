From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Aug 2017 13:10:58 +0300
Subject: [PATCH] arm64: dts: r8a7795: Drop bogus HDMI node names suffixes
In-Reply-To: <1504087397-6211-1-git-send-email-geert+renesas@glider.be>
References: <1504087397-6211-1-git-send-email-geert+renesas@glider.be>
Message-ID: <3276171.anaVMsVBRO@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Wednesday, 30 August 2017 13:03:17 EEST Geert Uytterhoeven wrote:
> Node names should not use numerical suffixes if the nodes can be
> distinguished by unit-address.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi index
> 8b4dbce860001224..e1ced54d11322cb4 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -2702,7 +2702,7 @@
>  			renesas,fcp = <&fcpf1>;
>  		};
> 
> -		hdmi0: hdmi0 at fead0000 {
> +		hdmi0: hdmi at fead0000 {
>  			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
>  			reg = <0 0xfead0000 0 0x10000>;
>  			interrupts = <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>;
> @@ -2727,7 +2727,7 @@
>  			};
>  		};
> 
> -		hdmi1: hdmi1 at feae0000 {
> +		hdmi1: hdmi at feae0000 {
>  			compatible = "renesas,r8a7795-hdmi", "renesas,rcar-gen3-hdmi";
>  			reg = <0 0xfeae0000 0 0x10000>;
>  			interrupts = <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH>;


-- 
Regards,

Laurent Pinchart
