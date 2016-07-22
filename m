From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 22 Jul 2016 12:08:33 +0200
Subject: [PATCH v3 3/7] clk: rockchip: rk3399: add SCLK_DDRCLK ID for ddrc
In-Reply-To: <1469178440-4668-4-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-4-git-send-email-hl@rock-chips.com>
Message-ID: <1486821.Jd4tDmJ7c4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. Juli 2016, 17:07:16 schrieb Lin Huang:
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v3:
> -None
> 
> Changes in v2:
> - None
> Changes in v1:
> - None
> 
>  include/dt-bindings/clock/rk3399-cru.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/rk3399-cru.h
> b/include/dt-bindings/clock/rk3399-cru.h index 50a44cf..8a0f0442 100644
> --- a/include/dt-bindings/clock/rk3399-cru.h
> +++ b/include/dt-bindings/clock/rk3399-cru.h
> @@ -131,6 +131,7 @@
>  #define SCLK_DPHY_RX0_CFG		165
>  #define SCLK_RMII_SRC			166
>  #define SCLK_PCIEPHY_REF100M		167
> +#define SCLK_DDRCLK			168

nit: SCLK_DDR (i.e. without the CLK at the end)?

>  #define DCLK_VOP0			180
>  #define DCLK_VOP1			181
