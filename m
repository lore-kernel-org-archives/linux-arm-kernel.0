From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 08 Feb 2016 11:29:30 +0100
Subject: [PATCH v2 09/10] Documentation: devicetree: rockchip: Document
 Landingship
In-Reply-To: <1454897859-7601-10-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-10-git-send-email-afaerber@suse.de>
Message-ID: <6744409.i2u8076vm4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 8. Februar 2016, 03:17:38 schrieb Andreas F?rber:
> Use "geekbuying,landingship" compatible string, plus those of GeekBox.

I do believe this would be better as geekbuying,geekbox-landingship . They 
might reuse the landingship naming for future baseboards as well ;-)

> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
> 
>  Documentation/devicetree/bindings/arm/rockchip.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
> b/Documentation/devicetree/bindings/arm/rockchip.txt index
> f633595b196c..c6d95f202591 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -91,6 +91,11 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "geekbuying,geekbox", "rockchip,rk3368";
> 
> +- GeekBuying Landingship:
> +    Required root node properties:
> +      - compatible = "geekbuying,landingship",
> +		     "geekbuying,geekbox", "rockchip,rk3368";
> +
>  - Rockchip RK3368 evb:
>      Required root node properties:
>        - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
