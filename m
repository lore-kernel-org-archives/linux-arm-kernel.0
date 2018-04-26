From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 26 Apr 2018 23:53:57 +0300
Subject: [PATCH 08/17] arm64: dts: r8a77965: Provide sysc header
 definitions
In-Reply-To: <20180426165346.494-9-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-9-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <2073410.9lt478HeGL@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:37 EEST Kieran Bingham wrote:
> Include the r8a77965-sysc header to provide power domain enumerations
> and definitions.

I think you can squash this with the first patch that will use the header.

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77965.dtsi index
> b12f41755aea..02de36b9e581 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -10,6 +10,7 @@
> 
>  #include <dt-bindings/clock/renesas-cpg-mssr.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/r8a77965-sysc.h>
> 
>  #define CPG_AUDIO_CLK_I		10

-- 
Regards,

Laurent Pinchart
