From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 17 Jun 2015 15:43:03 +0200
Subject: [PATCH] ARM: mvebu: adjust Armada XP DT spi muxing after pinctrl
 function rename
In-Reply-To: <1434023792-20455-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434023792-20455-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <55817967.8010909@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Arnd, Olof,

On 11/06/2015 13:56, Thomas Petazzoni wrote:
> Following the merge of "pinctrl: mvebu: armada-xp: rename spi to spi0"
> by Linus Walleij, we need to adjust the Armada XP Device Tree
> accordingly, by adjusting the pinctrl configuration for SPI pins.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


applied on mvebu/dt with the hope that it could be merged for 4.2
in order to avoid breakage.


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 013d63f..dba8d3f 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -289,7 +289,7 @@
>  	spi0_pins: spi0-pins {
>  		marvell,pins = "mpp36", "mpp37",
>  			       "mpp38", "mpp39";
> -		marvell,function = "spi";
> +		marvell,function = "spi0";
>  	};
>  
>  	uart2_pins: uart2-pins {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
