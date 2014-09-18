From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Sep 2014 15:31:37 +0200
Subject: [PATCH] ARM: at91/dt: Fix typo regarding can0_clk
In-Reply-To: <1410942812-31682-1-git-send-email-davidcdueck@googlemail.com>
References: <1410942812-31682-1-git-send-email-davidcdueck@googlemail.com>
Message-ID: <541ADEB9.5030807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/2014 10:33, David Dueck :
> Otherwise the clock for can0 will never get enabled.
> 
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on at91-3.18-dt3 branch. I will send it soon to arm-soc.

I also added the "stable" tag:
Cc: stable at vger.kernel.org # v3.14

Thanks a lot for this fix, best regards.

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
> 


-- 
Nicolas Ferre
