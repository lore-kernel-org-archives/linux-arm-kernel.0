From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Jul 2017 11:22:09 +0200
Subject: [PATCH 08/11] ARM: dts: sun8i: a83t: Add MMC controller device
 nodes
In-Reply-To: <20170714064302.20383-9-wens@csie.org>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-9-wens@csie.org>
Message-ID: <20170717092209.r55enf4ub7ttwpdy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 14, 2017 at 02:42:59PM +0800, Chen-Yu Tsai wrote:
> The A83T has 3 MMC controllers. The third one is a bit special, as it
> supports a wider 8-bit bus, and a "new timing mode".
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 57 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index beed05e10a3b..085312d0c521 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -182,6 +182,63 @@
>  			#dma-cells = <1>;
>  		};
>  
> +		mmc0: mmc at 1c0f000 {
> +			compatible = "allwinner,sun7i-a20-mmc";

Ideally, we should have an A83T compatible here too, just in case.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/43dbbfa9/attachment.sig>
