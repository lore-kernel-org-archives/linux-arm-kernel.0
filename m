From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 18 Jun 2016 23:35:15 +0900
Subject: [PATCH v2] clk: samsung: Remove useless check for return value of
 samsung_clk_init
In-Reply-To: <1462815151-14396-1-git-send-email-krzk@kernel.org>
References: <1462815151-14396-1-git-send-email-krzk@kernel.org>
Message-ID: <CA+Ln22GCD+DeeaB0J_S8ZE7UXWPjFghSHjG_Q4FLA9EoqdDp2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-05-10 2:32 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> The samsung_clk_init() cannot return NULL. Either it returns allocated
> memory or it panics.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
> Changes since v1:
> 1. Remove the check from most of other Samsung clock drivers (suggested
>    by Javier).
> ---
>  drivers/clk/samsung/clk-exynos4.c    | 2 --
>  drivers/clk/samsung/clk-exynos5250.c | 3 +--
>  drivers/clk/samsung/clk-exynos5420.c | 2 --
>  drivers/clk/samsung/clk-exynos5440.c | 2 --
>  drivers/clk/samsung/clk-s3c2410.c    | 2 --
>  drivers/clk/samsung/clk-s3c2412.c    | 2 --
>  drivers/clk/samsung/clk-s3c2443.c    | 2 --
>  drivers/clk/samsung/clk-s3c64xx.c    | 2 --
>  drivers/clk/samsung/clk-s5pv210.c    | 2 --
>  9 files changed, 1 insertion(+), 18 deletions(-)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
