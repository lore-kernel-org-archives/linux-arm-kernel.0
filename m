From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 08 Aug 2016 22:35:29 +0200
Subject: [PATCH 1/3] net: stmmac: dwmac-rk: add rk3366 & rk3399-specific
 data
In-Reply-To: <1467802291-6487-2-git-send-email-roger.chen@rock-chips.com>
References: <1467802291-6487-1-git-send-email-roger.chen@rock-chips.com>
 <1467802291-6487-2-git-send-email-roger.chen@rock-chips.com>
Message-ID: <3635712.eAtD6Fn9AW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

Am Mittwoch, 6. Juli 2016, 18:51:29 schrieb Roger Chen:
> Add constants and callback functions for the dwmac on rk3368 socs.
> As can be seen, the base structure is the same, only registers and
> the bits in them moved slightly.
> 
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> ---
>  .../devicetree/bindings/net/rockchip-dwmac.txt     |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 226
> +++++++++++++++++++++ 2 files changed, 228 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt index
> 93eac7c..8c066e6 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
> @@ -3,7 +3,8 @@ Rockchip SoC RK3288 10/100/1000 Ethernet driver(GMAC)
>  The device node has following properties.
> 
>  Required properties:
> - - compatible: Can be one of "rockchip,rk3288-gmac", "rockchip,rk3368-gmac"
> + - compatible: Can be one of "rockchip,rk3288-gmac",
> "rockchip,rk3366-gmac", +                            
> "rockchip,rk3368-gmac", "rockchip,rk3399-gmac" - reg: addresses and length
> of the register sets for the device. - interrupts: Should contain the GMAC
> interrupts.
>   - interrupt-names: Should contain the interrupt names "macirq".

this doesn't apply against 4.8-rc1 anymore, can you please rebase and resend 
the series?


Thanks
Heiko
