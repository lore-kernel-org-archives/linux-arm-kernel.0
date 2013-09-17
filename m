From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 17 Sep 2013 10:02:04 +0200
Subject: [PATCH 09/10] clk: ux500: Remove extra semicolon
In-Reply-To: <1379064232-10261-9-git-send-email-sachin.kamat@linaro.org>
References: <1379064232-10261-1-git-send-email-sachin.kamat@linaro.org>
 <1379064232-10261-9-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAPDyKFpHM8jxwRV_k0T3Fid3KsjoRdyLLqVhxenM2gGrneUUCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 11:23, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Extra semicolon is redundant. Remove it.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/ux500/clk-prcmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index 293a288..e2d63bc 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -36,7 +36,7 @@ static int clk_prcmu_prepare(struct clk_hw *hw)
>         if (!ret)
>                 clk->is_prepared = 1;
>
> -       return ret;;
> +       return ret;
>  }
>
>  static void clk_prcmu_unprepare(struct clk_hw *hw)
> --
> 1.7.9.5
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
