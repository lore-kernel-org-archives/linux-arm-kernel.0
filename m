From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Jul 2013 16:36:26 +0900
Subject: [PATCH 0/6] clk: exynos: Some fixes and cleanup
In-Reply-To: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
References: <1373533334-5169-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <02dc01ce81f7$2d9fb6b0$88df2410$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Resending some of patches (1, 3 and 5) as per discussion in thread [1].
> Other patches in the series are new.
> 
> [1] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/19933
> 
> Sachin Kamat (6):
>   clk: exynos4: Staticize local symbols
>   clk: exynos4: Remove unused function
>   clk: exynos5250: Staticize local symbols
>   clk: exynos5420: Staticize local symbols
>   clk: exynos5440: Staticize local symbols
>   clk: exynos-audss: Staticize exynos_audss_clk_init
> 
>  drivers/clk/samsung/clk-exynos-audss.c |    2 +-
>  drivers/clk/samsung/clk-exynos4.c      |   42
++++++++++++-----------------
> ---
>  drivers/clk/samsung/clk-exynos5250.c   |   14 +++++------
>  drivers/clk/samsung/clk-exynos5420.c   |   14 +++++------
>  drivers/clk/samsung/clk-exynos5440.c   |   14 +++++------
>  5 files changed, 37 insertions(+), 49 deletions(-)
> 
> --
> 1.7.9.5

There are small comments on 1st and 2nd patches.
Others look good to me.

For 3rd~6th patches:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
- Kukjin
