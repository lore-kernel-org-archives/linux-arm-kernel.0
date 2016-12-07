From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 7 Dec 2016 04:10:48 +0100
Subject: [PATCH] n900 device tree: cleanup
In-Reply-To: <20161011081243.GA24580@amd>
References: <20161011075416.GA22453@amd>
 <20161011081243.GA24580@amd>
Message-ID: <20161207031048.pi7j4dms5uuco3yf@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

It looks like this fell through the cracks. Apart from inconsistent
patch subject:

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

On Tue, Oct 11, 2016 at 10:12:43AM +0200, Pavel Machek wrote:
> Fix GPIO comment to be consistent with rest of file and add comment what
> tpa6130 is.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index bfffd6c..ca9fe8c 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -47,7 +47,7 @@
>  		compatible = "gpio-leds";
>  		heartbeat {
>  			label = "debug::sleep";
> -			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
> +			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
>  			linux,default-trigger = "default-on";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&debug_leds>;
> @@ -637,6 +637,7 @@
>  		reg = <0x55>;
>  	};
>  
> +	/* Stereo headphone amplifier */
>  	tpa6130a2: tpa6130a2 at 60 {
>  		compatible = "ti,tpa6130a2";
>  		reg = <0x60>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/6681dd12/attachment.sig>
