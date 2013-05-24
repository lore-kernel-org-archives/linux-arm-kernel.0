From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 24 May 2013 23:55:03 +0200
Subject: [RESEND PATCH 1/5] clk: samsung: Use clk->base instead of
 directly using clk->con0 for PLL3xxx
In-Reply-To: <1369391478-7665-2-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
 <1369391478-7665-2-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <4808417.0aThqqOIhP@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 24 of May 2013 16:01:14 Vikas Sajjan wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
> 
> To factor out possible common code, this patch unifies the clk strutures
> used for PLL35xx & PLL36xx and usues clk->base instead of clk->con0.
> 
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |   10 ++++---
>  drivers/clk/samsung/clk-exynos5250.c |   14 ++++-----
>  drivers/clk/samsung/clk-pll.c        |   54
> ++++++++++++++++++---------------- drivers/clk/samsung/clk-pll.h       
> |    4 +--
>  4 files changed, 44 insertions(+), 38 deletions(-)
> 

Whether this patch really allows to factor out any significant amount of 
common code is rather discussible, but generally looks fine.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
