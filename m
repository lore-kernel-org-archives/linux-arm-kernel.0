From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 13 Apr 2014 15:41:38 +0800
Subject: [PATCH BUGFIX] arm: dts: imx53: fix apparent copy/paste error
In-Reply-To: <1397117020-8900-1-git-send-email-LW@KARO-electronics.de>
References: <1397117020-8900-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140413074137.GC24180@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 10:03:40AM +0200, Lothar Wa?mann wrote:
> The 'remote-endpoint' property should point back to ipu_di1_lvds1
> rather than ipu_di0_lvds0.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Changed 'arm:' in patch subject to 'ARM:', and applied the patch.

Shawn

> ---
>  arch/arm/boot/dts/imx53.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index f0962e5..33a4e5b 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -431,7 +431,7 @@
>  
>  					port {
>  						lvds1_in: endpoint {
> -							remote-endpoint = <&ipu_di0_lvds0>;
> +							remote-endpoint = <&ipu_di1_lvds1>;
>  						};
>  					};
>  				};
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
