From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 22 Jul 2013 11:05:15 -0700
Subject: [PATCH v2 0/6] clk: exynos: Some fixes and cleanup
In-Reply-To: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
References: <1374141682-29432-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130722180515.7598.56428@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2013-07-18 03:01:16)
> Resending some of patches (1, 3 and 5) as per discussion in thread [1].
> Other patches in the series are new.
> 
> [1] http://comments.gmane.org/gmane.linux.kernel.samsung-soc/19933
> 
> Changes since v1:
> * Removed an unnecessary change in Patch 1 as pointed out by Kukjin Kim.
> * Added Kukjin's ack to patches 3~6.

Thanks for the fixes! Will take into clk-next unless you need them to go
into -rc3, but I don't think there are any regression fixes here.

Regards,
Mike

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
>  drivers/clk/samsung/clk-exynos4.c      |   42 ++++++++++++--------------------
>  drivers/clk/samsung/clk-exynos5250.c   |   14 +++++------
>  drivers/clk/samsung/clk-exynos5420.c   |   14 +++++------
>  drivers/clk/samsung/clk-exynos5440.c   |   14 +++++------
>  5 files changed, 37 insertions(+), 49 deletions(-)
> 
> -- 
> 1.7.9.5
