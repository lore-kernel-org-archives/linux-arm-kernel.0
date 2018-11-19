From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 19 Nov 2018 14:43:03 +0100
Subject: [PATCH] clk: rockchip: fix ID of 8ch clock of I2S1 for rk3328
In-Reply-To: <20181118041802.11660-1-katsuhiro@katsuster.net>
References: <20181118041802.11660-1-katsuhiro@katsuster.net>
Message-ID: <12656761.yaB328pSP6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 18. November 2018, 05:18:02 CET schrieb Katsuhiro Suzuki:
> This patch fixes mistakes in HCLK_I2S1_8CH for running I2S1
> successfully.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  include/dt-bindings/clock/rk3328-cru.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
> index a82a0109faff..bcaa4559ab1b 100644
> --- a/include/dt-bindings/clock/rk3328-cru.h
> +++ b/include/dt-bindings/clock/rk3328-cru.h
> @@ -172,13 +172,14 @@
>  #define PCLK_HDCP		232
>  #define PCLK_DCF		233
>  #define PCLK_SARADC		234
> +#define PCLK_ACODECPHY		235

I've dropped this unrelated change and applied the
real id fix from the rest of the patch for 4.21


Thanks
Heiko
