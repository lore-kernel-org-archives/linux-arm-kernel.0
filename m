From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:42:17 -0600
Subject: [PATCH 1/2] dt-bindings: add Asus Tinker board
In-Reply-To: <1484791919-4665-2-git-send-email-eddie.cai@rock-chips.com>
References: <1484791919-4665-1-git-send-email-eddie.cai@rock-chips.com>
 <1484791919-4665-2-git-send-email-eddie.cai@rock-chips.com>
Message-ID: <20170121204217.y54lup7wkm7y7iwp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 10:11:58AM +0800, Eddie Cai wrote:
> Tinker board is a credit card size develop board designed by Asus.
> Powered by RK3288.
> 
> Signed-off-by: Eddie Cai <eddie.cai@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index cc4ace6..ce1f04a 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -1,5 +1,8 @@
>  Rockchip platforms device tree bindings
>  ---------------------------------------
> +- Asus Tinker board
> +    Required root node properties:
> +      - compatible = "rockchip,rk3288-tinker", "rockchip,rk3288";

This should be asus,tinker if that's specific enough. At least the board 
manufacturer should be the vendor.

>  
>  - Kylin RK3036 board:
>      Required root node properties:
> -- 
> 2.7.4
> 
