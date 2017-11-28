From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Nov 2017 08:02:37 -0800
Subject: [PATCH v3 3/4] DTS: GTA04: fix panel compatibility string
In-Reply-To: <5f68789942fb8063ba5a98f5dd7989a05f94c0d6.1511884135.git.hns@goldelico.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <5f68789942fb8063ba5a98f5dd7989a05f94c0d6.1511884135.git.hns@goldelico.com>
Message-ID: <20171128160237.GC28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
> Official vendor string is now "tpo" and not "toppoly".
> 
> Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"

This is not a fix then, this is a clean up as you change the compatible
earlier. Please resend this separately once the driver changes have
been merged.

Regards,

Tony

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 4504908c23fe..ec27ed67a22a 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -86,7 +86,7 @@
>  
>  		/* lcd panel */
>  		lcd: td028ttec1 at 0 {
> -			compatible = "toppoly,td028ttec1";
> +			compatible = "tpo,td028ttec1";
>  			reg = <0>;
>  			spi-max-frequency = <100000>;
>  			spi-cpol;
> -- 
> 2.12.2
> 
