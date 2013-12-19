From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 19 Dec 2013 21:55:27 +0100
Subject: [PATCH Resend 6/7] clk: ux500: Remove extra semicolon
In-Reply-To: <1387443241-5694-6-git-send-email-sachin.kamat@linaro.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
 <1387443241-5694-6-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAPDyKFoa37Y1wUA0kP+HyWA4--=-1hf2FsB+2_nRxj3QFKGB2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 December 2013 09:54, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Extra semicolon is redundant. Remove it.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to my clk-next-ux500 branch.

Thanks!
Ulf Hansson

> ---
>  drivers/clk/ux500/clk-prcmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index 293a28854417..e2d63bc47436 100644
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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
