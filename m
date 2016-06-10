From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 11:39:22 +0200
Subject: [linux-sunxi] [PATCH] [V2] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <20160603061336.16263-1-luoyi.ly@gmail.com>
References: <574FF94B.3020309@web.de>
 <20160603061336.16263-1-luoyi.ly@gmail.com>
Message-ID: <20160610093922.GR5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 02:13:36PM +0800, luoyi.ly at gmail.com wrote:
> From: Luo Yi <luoyi.ly@gmail.com>
> 
> Remove the extra empty line and add signed off. 
> 
> Signed-off-by: Luo Yi <luoyi.ly@gmail.com>

Please send a new patch.

> ---
>  arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
> index 6fd55d7..f9063ba 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
> @@ -47,7 +47,6 @@
>  	compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
>  };
>  
> -
>  &codec {
>  	status = "okay";
>  };
> @@ -62,11 +61,8 @@
>  		interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>; 
>  		interrupt-names = "host-wake";
>  	};
> -
>  };
>  
>  &mmc3_pins_a {
> -    /* AP6210 requires pull-up */

And that comment was fine, why did you remove it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/d6dafede/attachment.sig>
