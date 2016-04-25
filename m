From: rdunlap@infradead.org (Randy Dunlap)
Date: Sun, 24 Apr 2016 20:00:51 -0700
Subject: [PATCH 09/41] Documentation: dt: clock: fix spelling mistakes
In-Reply-To: <1461543878-3639-10-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-10-git-send-email-eric@engestrom.ch>
Message-ID: <571D8863.3030202@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/16 17:24, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---
>  Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt | 2 +-
>  Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt | 2 +-
>  Documentation/devicetree/bindings/clock/st/st,clkgen.txt        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> index 0c2bf5e..7f36853 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.txt
> @@ -16,7 +16,7 @@ Required Properties:
>  Optional Properties:
>  
>  - rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changable, due to the missing pll lock status.
> +  If missing pll rates are not changeable, due to the missing pll lock status.
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume. All available clocks are defined as
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> index c9fbb76..8cb47c3 100644
> --- a/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
> @@ -15,7 +15,7 @@ Required Properties:
>  Optional Properties:
>  
>  - rockchip,grf: phandle to the syscon managing the "general register files"
> -  If missing pll rates are not changable, due to the missing pll lock status.
> +  If missing pll rates are not changeable, due to the missing pll lock status.
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume. All available clocks are defined as
> diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> index 78978f1..426bdda 100644
> --- a/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> +++ b/Documentation/devicetree/bindings/clock/st/st,clkgen.txt
> @@ -40,7 +40,7 @@ address is common of all subnode.
>  	};
>  
>  This binding uses the common clock binding[1].
> -Each subnode should use the binding discribe in [2]..[7]
> +Each subnode should use the binding describe in [2]..[7]

described ?

>  
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  [2] Documentation/devicetree/bindings/clock/st,clkgen-divmux.txt
> 


-- 
~Randy
