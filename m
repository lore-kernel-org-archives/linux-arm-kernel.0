From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Nov 2016 17:49:27 +0100
Subject: [PATCH] arm64: dts: marvell: Fix typo in label name on Armada 37xx
In-Reply-To: <20161108163216.24470-1-gregory.clement@free-electrons.com>
References: <20161108163216.24470-1-gregory.clement@free-electrons.com>
Message-ID: <20161108174927.1ccfc47e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue,  8 Nov 2016 17:32:16 +0100, Gregory CLEMENT wrote:
> The label names of the peripheral clocks have a typo. Fix it before it is
> more widely used.
> 
> Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> -			nb_perih_clk: nb-periph-clk at 13000{
> +			nb_periph_clk: nb-periph-clk at 13000{

Space before {

>  				compatible = "marvell,armada-3700-periph-clock-nb";
>  				reg = <0x13000 0x100>;
>  				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
> @@ -113,7 +113,7 @@
>  				#clock-cells = <1>;
>  			};
>  
> -			sb_perih_clk: sb-periph-clk at 18000{
> +			sb_periph_clk: sb-periph-clk at 18000{

Ditto.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
