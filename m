From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 3 Jun 2016 20:34:52 +0800
Subject: [RFC PATCH v1 2/6] clk: rockchip: rk3399: add SCLK_DDRCLK ID for
 ddrc
In-Reply-To: <1464947719-6245-3-git-send-email-hl@rock-chips.com>
References: <1464947719-6245-1-git-send-email-hl@rock-chips.com>
 <1464947719-6245-3-git-send-email-hl@rock-chips.com>
Message-ID: <9d392979-0a20-ca74-9699-2440d07dddd3@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin

How about merge it into your patch#3.

On 2016/6/3 17:55, Lin Huang wrote:
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v1:
> - None
>
>  include/dt-bindings/clock/rk3399-cru.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
> index 50a44cf..8a0f0442 100644
> --- a/include/dt-bindings/clock/rk3399-cru.h
> +++ b/include/dt-bindings/clock/rk3399-cru.h
> @@ -131,6 +131,7 @@
>  #define SCLK_DPHY_RX0_CFG		165
>  #define SCLK_RMII_SRC			166
>  #define SCLK_PCIEPHY_REF100M		167
> +#define SCLK_DDRCLK			168
>
>  #define DCLK_VOP0			180
>  #define DCLK_VOP1			181
>


-- 
Best Regards
Shawn Lin
