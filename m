From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 23 Jan 2015 08:36:28 +0100
Subject: [PATCH] clk: ux500: Drop use of clk-private.h
In-Reply-To: <1421955259-8875-1-git-send-email-sboyd@codeaurora.org>
References: <1421955259-8875-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAPDyKFrVseR_Mczn5q0pjcMk6SN1HCebWTis4wOfcH+vfEDnRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2015 at 20:34, Stephen Boyd <sboyd@codeaurora.org> wrote:
> These drivers don't need to include clk-private.h. Remove the
> include.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

I suppose you can queue this through your clk tree directly?

Kind regards
Uffe

> ---
>  drivers/clk/ux500/clk-prcc.c  | 1 -
>  drivers/clk/ux500/clk-prcmu.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
> index bd4769a84485..0e950769ed03 100644
> --- a/drivers/clk/ux500/clk-prcc.c
> +++ b/drivers/clk/ux500/clk-prcc.c
> @@ -8,7 +8,6 @@
>   */
>
>  #include <linux/clk-provider.h>
> -#include <linux/clk-private.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
> diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
> index e2d63bc47436..bf63c96acb1a 100644
> --- a/drivers/clk/ux500/clk-prcmu.c
> +++ b/drivers/clk/ux500/clk-prcmu.c
> @@ -8,7 +8,6 @@
>   */
>
>  #include <linux/clk-provider.h>
> -#include <linux/clk-private.h>
>  #include <linux/mfd/dbx500-prcmu.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
