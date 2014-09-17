From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 17 Sep 2014 20:32:29 +0200
Subject: [PATCH] ARM: at91/dt: Fix typo regarding can0_clk
In-Reply-To: <1410942812-31682-1-git-send-email-davidcdueck@googlemail.com>
References: <1410942812-31682-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <20140917203229.01600058@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David, Anthony,

On Wed, 17 Sep 2014 10:33:32 +0200
David Dueck <davidcdueck@googlemail.com> wrote:

> Otherwise the clock for can0 will never get enabled.
> 
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>

Thanks for fixing that.

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  arch/arm/boot/dts/sama5d3_can.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3_can.dtsi b/arch/arm/boot/dts/sama5d3_can.dtsi
> index a077585..eaf4145 100644
> --- a/arch/arm/boot/dts/sama5d3_can.dtsi
> +++ b/arch/arm/boot/dts/sama5d3_can.dtsi
> @@ -40,7 +40,7 @@
>  						atmel,clk-output-range = <0 66000000>;
>  					};
>  
> -					can1_clk: can0_clk {
> +					can1_clk: can1_clk {
>  						#clock-cells = <0>;
>  						reg = <41>;
>  						atmel,clk-output-range = <0 66000000>;



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
