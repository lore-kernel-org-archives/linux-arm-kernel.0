From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Nov 2013 13:59:09 +0900
Subject: [PATCH] ARM: shmobile: Use r8a7790 suffix for IRQC compat string
In-Reply-To: <20131120000740.27032.66529.sendpatchset@w520>
References: <20131120000740.27032.66529.sendpatchset@w520>
Message-ID: <20131121045907.GV31130@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 09:07:40AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add "renesas,irqc-r8a7790" to the compatible string for IRQC
> in case of r8a7790. This makes the IRQC follow the same style
> as the other devices and also makes it more future proof.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7790.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> 
> --- 0003/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 08:20:30.000000000 +0900
> @@ -171,7 +171,7 @@
>  	};
>  
>  	irqc0: interrupt-controller at e61c0000 {
> -		compatible = "renesas,irqc";
> +		compatible = "renesas,irqc-r8a7790", "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
>  		reg = <0 0xe61c0000 0 0x200>;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
