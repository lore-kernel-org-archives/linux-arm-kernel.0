From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:45:05 -0800
Subject: [PATCH 1/3] arm: dts: am33xx.dtsi: Add node name to rtc device
 node
In-Reply-To: <1391602361-2666-1-git-send-email-sr@denx.de>
References: <1391602361-2666-1-git-send-email-sr@denx.de>
Message-ID: <20140228224504.GQ13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stefan Roese <sr@denx.de> [140205 04:14]:
> Making it possible to reference and therefor change (disable) this
> device node from other dts file which import this dtsi file.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Lukas Stockmann <lukas.stockmann@siemens.com>
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>

Thanks applying into omap-for-v3.15/dt.

Tony

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..b8daf8c 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -399,7 +399,7 @@
>  			ti,timer-pwm;
>  		};
>  
> -		rtc at 44e3e000 {
> +		rtc: rtc at 44e3e000 {
>  			compatible = "ti,da830-rtc";
>  			reg = <0x44e3e000 0x1000>;
>  			interrupts = <75
> -- 
> 1.8.5.3
> 
