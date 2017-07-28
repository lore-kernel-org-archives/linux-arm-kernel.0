From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Jul 2017 11:25:36 +0200
Subject: [PATCH v6 6/7] dt-bindings: display: rockchip: fill Documents for
 vop series
In-Reply-To: <1501049975-6185-1-git-send-email-mark.yao@rock-chips.com>
References: <1501049930-5794-1-git-send-email-mark.yao@rock-chips.com>
 <1501049975-6185-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2981514.6HN6ClsfAP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Mittwoch, 26. Juli 2017, 14:19:35 CEST schrieb Mark Yao:
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v5:
> - clean document commit title
> - move changes description out of docummit commit msg
> 
> Changes in v2:
> - rename rk322x to rk3228
> - correct some vop registers define
> 
>  Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> index 9eb3f0a..5d835d9 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> @@ -8,8 +8,12 @@ Required properties:
>  - compatible: value should be one of the following
>  		"rockchip,rk3036-vop";
>  		"rockchip,rk3288-vop";
> +		"rockchip,rk3368-vop";
> +		"rockchip,rk3366-vop";
>  		"rockchip,rk3399-vop-big";
>  		"rockchip,rk3399-vop-lit";
> +		"rockchip,rk3228-vop";
> +		"rockchip,rk3328-vop";

what is your ordering scheme here?
As the number of rkXXXX socs will very likely increase in the future
ordering alphanumerical might make everything more manageable when
the list grows.

So maybe swap rk3368 and rk3366 and move rk3228+rk3328 to sorted
positions?


Heiko
