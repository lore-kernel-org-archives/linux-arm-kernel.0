From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 27 Apr 2018 00:16:27 +0300
Subject: [PATCH 09/17] arm64: dts: r8a77965: Use the correct CPG header
In-Reply-To: <20180426165346.494-10-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-10-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <4644695.5hyXcXK7su@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:38 EEST Kieran Bingham wrote:
> The SoC dtsi includes the generic renesas-cpg-mssr header, which does
> not contain all of the relevant SoC specific definitions.
> 
> Adapt this to be the r8a77965 specific header.

I would squash this with patch 13/17.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
> 02de36b9e581..894903a59bdc 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2016 Renesas Electronics Corp.
>   */
> 
> -#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/r8a77965-sysc.h>


-- 
Regards,

Laurent Pinchart
