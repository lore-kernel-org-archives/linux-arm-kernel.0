From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 14:34:23 +0200
Subject: [PATCH v6 2/4] ARM: dts: sun8i: a83t: Add support for the cir
 interface
In-Reply-To: <20180731092258.2279-3-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
 <20180731092258.2279-3-embed3d@gmail.com>
Message-ID: <20180731123423.vfcc2ubmtikk7ycy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:22:56AM +0200, Philipp Rossak wrote:
> The cir interface is like on the H3 located at 0x01f02000 and is exactly
> the same. This patch adds support for the ir interface on the A83T.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index afed6c0dea6f..31222a05a8f1 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -992,6 +992,18 @@
>  			reg = <0x1f01c00 0x400>;
>  		};
>  
> +		r_cir: ir at 1f02000 {
> +			compatible = "allwinner,sun5i-a13-ir";

You should have an a83t compatile in addition here.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
