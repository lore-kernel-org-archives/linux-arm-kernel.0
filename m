From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Feb 2018 20:36:24 +0100
Subject: [PATCH v3 4/4] ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and
 mmc1_pins_a
In-Reply-To: <20180208120141.15780-5-joonas.kylmala@iki.fi>
References: <20180208120141.15780-1-joonas.kylmala@iki.fi>
 <20180208120141.15780-5-joonas.kylmala@iki.fi>
Message-ID: <20180208193624.e7y32gvscuppmtj5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 08, 2018 at 02:01:41PM +0200, Joonas Kylm?l? wrote:
> There is only one pinctrl configuration for mmc0 and mmc1 so let's
> drop the _a suffix from both of them.
> 
> Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 2 +-
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi                | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> index 73978853bb4c..f868cf197c8e 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
> @@ -134,7 +134,7 @@
>  	};
>  };
>  
> -&mmc1_pins_a {
> +&mmc1_pins {
>  	bias-pull-up;
>  };

I've queued all four patches for 4.17, but this isn't needed at all,
since the pull up should already be set in the pinctrl node. Can you
send another patch removing it?

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/e1f092e5/attachment.sig>
