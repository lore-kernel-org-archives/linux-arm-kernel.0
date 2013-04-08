From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 08 Apr 2013 16:22:51 +0900
Subject: [PATCH] clk: exynos4: export clocks required for fimc-is
In-Reply-To: <20130405183221.7302.97946@quantum>
References: <1365184185-23794-1-git-send-email-s.nawrocki@samsung.com>
 <20130405183221.7302.97946@quantum>
Message-ID: <2c8f01ce3429$e110ef50$a332cdf0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette wrote:
> 
> Quoting Sylwester Nawrocki (2013-04-05 10:49:45)
> > This patch adds clock indexes for ACLK_DIV0, ACLK_DIV1,
> > ACLK_400_MCUISP, ACLK_MCUISP_DIV0, ACLK_MCUISP_DIV1,
> > DIVACLK_400_MCUISP and DIVACLK_200 so these clocks are
> > available to the consumers (Exynos4x12 FIMC-IS subsystem).
> > While at it, indentation of the mux clocks table is
> > corrected.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> 
Thanks, applied into next/clk-exynos.

- Kukjin
