From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 19 Apr 2016 09:58:52 +0200
Subject: [PATCH 2/2] dt-bindings: add document for rk3399-vop
In-Reply-To: <1460949478-2236-2-git-send-email-mark.yao@rock-chips.com>
References: <1460949478-2236-1-git-send-email-mark.yao@rock-chips.com>
 <1460949478-2236-2-git-send-email-mark.yao@rock-chips.com>
Message-ID: <6435836.sTKjWLANC0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

patch subject above:
dt-bindings: add documentation for Rockchip rk3399 display controllers

not everybody skimming over patches directly knows what a vop is ;-)

I still believe even such a trivial patch should also get some form of 
description, something like:

---------
Document compatible values for rk3399 display controllers.
Big and little display controllers are not identical and have differing 
feature sets on the rk3399.
---------

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  .../bindings/display/rockchip/rockchip-vop.txt     |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt index
> 5489b59..fd25ea9 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> @@ -8,6 +8,8 @@ Required properties:
>  - compatible: value should be one of the following
>  		"rockchip,rk3288-vop";
>  		"rockchip,rk3036-vop";
> +		"rockchip,rk3399-vop-big";
> +		"rockchip,rk3399-vop-lit";
> 
>  - interrupts: should contain a list of all VOP IP block interrupts in the
>  		 order: VSYNC, LCD_SYSTEM. The interrupt specifier
