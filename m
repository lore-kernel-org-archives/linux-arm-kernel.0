From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 09 Nov 2017 05:36:23 +0200
Subject: [PATCH 3/4] DTS: Pandora: fix panel compatibility string
In-Reply-To: <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
References: <cover.1510175371.git.hns@goldelico.com>
 <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
Message-ID: <1634573.IyLVzmLhWc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

Thank you for the patch.

On Wednesday, 8 November 2017 23:09:31 EET H. Nikolaus Schaller wrote:
> We can remove the "omapdss," prefix.

I agree but you should explain why.

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> b/arch/arm/boot/dts/omap3-pandora-common.dtsi index
> 53e007abdc71..64d967ec8c58 100644
> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -626,7 +626,7 @@
> 
>  	lcd: lcd at 1 {
>  		reg = <1>;	/* CS1 */
> -		compatible =	"omapdss,tpo,td043mtea1";
> +		compatible =	"tpo,td043mtea1";
>  		spi-max-frequency = <100000>;
>  		spi-cpol;
>  		spi-cpha;


-- 
Regards,

Laurent Pinchart
