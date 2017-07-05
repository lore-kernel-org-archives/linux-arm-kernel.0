From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 05 Jul 2017 11:26:34 +0900
Subject: [PATCH] ARM: dts: lpc18xx: remove num-slots from lpc18xx
In-Reply-To: <1499160862-87345-1-git-send-email-shawn.lin@rock-chips.com>
References: <CGME20170704093434epcas5p304d945fe8950a0a7adfbac3cea942d57@epcas5p3.samsung.com>
 <1499160862-87345-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <c28884cc-95c9-4c84-8af5-12f3c1623926@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 06:34 PM, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  arch/arm/boot/dts/lpc18xx.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
> index 7cae9c5..10b8249 100644
> --- a/arch/arm/boot/dts/lpc18xx.dtsi
> +++ b/arch/arm/boot/dts/lpc18xx.dtsi
> @@ -115,7 +115,6 @@
>  			compatible = "snps,dw-mshc";
>  			reg = <0x40004000 0x1000>;
>  			interrupts = <6>;
> -			num-slots = <1>;
>  			clocks = <&ccu2 CLK_SDIO>, <&ccu1 CLK_CPU_SDIO>;
>  			clock-names = "ciu", "biu";
>  			resets = <&rgu 20>;
> 
