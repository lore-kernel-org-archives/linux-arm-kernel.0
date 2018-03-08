From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 08 Mar 2018 10:55:06 +0900
Subject: [PATCH] clk: samsung: exynos5420: Add more entries to EPLL rate
 table
In-Reply-To: <20180307164656.12194-2-s.nawrocki@samsung.com>
References: <20180307164656.12194-1-s.nawrocki@samsung.com>
 <CGME20180307164733epcas1p3695c022315be8d2839ac9e88016e3a76@epcas1p3.samsung.com>
 <20180307164656.12194-2-s.nawrocki@samsung.com>
Message-ID: <5AA097FA.5070704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 03? 08? 01:46, Sylwester Nawrocki wrote:
> Adding these EPLL output frequency entries allows to support all required
> audio sample rates on the CODEC and the HDMI interface on Peach-Pit
> Chromebook.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 1f204ba37f0f..f2607cb97a97 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1360,8 +1360,11 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(180633609U, 301, 5, 3, 3671),
>  	PLL_36XX_RATE(131072006U, 131, 3, 3, 4719),
>  	PLL_36XX_RATE(100000000U, 200, 3, 4, 0),
> +	PLL_36XX_RATE( 73728000U, 98, 2, 4, 19923),
> +	PLL_36XX_RATE( 67737602U, 90, 2, 4, 20762),
>  	PLL_36XX_RATE( 65536003U, 131, 3, 4, 4719),
>  	PLL_36XX_RATE( 49152000U, 197, 3, 5, -25690),
> +	PLL_36XX_RATE( 45158401U, 90, 3, 4, 20762),
>  	PLL_36XX_RATE( 32768001U, 131, 3, 5, 4719),
>  };
>  
> 

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
