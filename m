From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Dec 2017 10:53:50 +0100
Subject: [PATCH 1/2] arm: dts: sun8i: a83t: remove leading zero from
 cpucfg node address
In-Reply-To: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
References: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
Message-ID: <20171214095350.ymwkmshinveij7of@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 13, 2017 at 08:37:14PM +0100, Corentin Labbe wrote:
> This will fix the following warning:
> Warning (simple_bus_reg): Node /soc/cpucfg at 01700000 simple-bus unit address format error, expected "1700000"
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 7b372acf4bf6..715719f9ea2e 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -377,7 +377,7 @@
>  			#reset-cells = <1>;
>  		};
>  
> -		cpucfg at 01700000 {
> +		cpucfg at 1700000 {
>  			compatible = "allwinner,sun9i-a80-cpucfg";
>  			reg = <0x01700000 0x100>;

That node isn't upstream.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171214/b94b4a36/attachment.sig>
