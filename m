From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Apr 2016 09:31:34 +0200
Subject: [PATCH 09/41] Documentation: dt: clock: fix spelling mistakes
In-Reply-To: <1461543878-3639-10-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-10-git-send-email-eric@engestrom.ch>
Message-ID: <2265117.YTl3hp9ROk@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. April 2016, 01:24:06 schrieb Eric Engestrom:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---
>  Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt | 2 +-
>  Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt | 2 +-
>  Documentation/devicetree/bindings/clock/st/st,clkgen.txt        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt index
> 0c2bf5e..7f36853 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> @@ -16,7 +16,7 @@ Required Properties:
>  Optional Properties:
> 
>  - rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changable, due to the missing pll lock
> status. +  If missing pll rates are not changeable, due to the missing pll
> lock status.
> 
>  Each clock is assigned an identifier and client nodes can use this
> identifier to specify the clock which they consume. All available clocks
> are defined as diff --git
> a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt index
> c9fbb76..8cb47c3 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> @@ -15,7 +15,7 @@ Required Properties:
>  Optional Properties:
> 
>  - rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changable, due to the missing pll lock
> status. +  If missing pll rates are not changeable, due to the missing pll
> lock status.
> 
>  Each clock is assigned an identifier and client nodes can use this
> identifier to specify the clock which they consume. All available clocks
> are defined as

For the Rockchip parts
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
