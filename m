From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 18 Dec 2013 15:54:30 +0100
Subject: [PATCH] clk: samsung: exynos4: Correct SRC_MFC register
In-Reply-To: <1385097668-24620-1-git-send-email-sw0312.kim@samsung.com>
References: <1385097668-24620-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <4859492.2SOgx7UbdE@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 of November 2013 14:21:08 Seung-Woo Kim wrote:
> The SRC_MFC register was incorrect. This patch corrects it.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
> index ad5ff50..1a7c1b9 100644
> --- a/drivers/clk/samsung/clk-exynos4.c
> +++ b/drivers/clk/samsung/clk-exynos4.c
> @@ -39,7 +39,7 @@
>  #define SRC_TOP1		0xc214
>  #define SRC_CAM			0xc220
>  #define SRC_TV			0xc224
> -#define SRC_MFC			0xcc28
> +#define SRC_MFC			0xc228
>  #define SRC_G3D			0xc22c
>  #define E4210_SRC_IMAGE		0xc230
>  #define SRC_LCD0		0xc234
> 

Applied into samsung-clk fixes branch.

Best regards,
Tomasz
