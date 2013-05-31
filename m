From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 May 2013 10:08:39 -0700
Subject: [PATCH v3 2/6] clk: samsung: Add support to register rate_table
 for PLL3xxx
In-Reply-To: <1370003496-19288-3-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-3-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=XnzS8TuvtGRrZ+jN=8AUYr-imL1bRsdWY3BDQVwm615g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas and Yadwinder,

On Fri, May 31, 2013 at 5:31 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>
> This patch defines a common rate_table which will contain recommended p, m, s,
> k values for supported rates that needs to be changed for changing
> corresponding PLL's rate.
>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |    8 ++++----
>  drivers/clk/samsung/clk-exynos5250.c |   14 +++++++-------
>  drivers/clk/samsung/clk-pll.c        |   14 ++++++++++++--
>  drivers/clk/samsung/clk-pll.h        |   35 ++++++++++++++++++++++++++++++++--
>  4 files changed, 56 insertions(+), 15 deletions(-)

This looks good to me.  Hopefully Tomasz agrees.  Tomasz: if you
haven't been following this thread, see
<https://patchwork.kernel.org/patch/2643351/> for how we resolved the
constant vs. calculated input clock.

Reviewed-by: Doug Anderson <dianders@chromium.org>
