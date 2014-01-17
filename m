From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 17 Jan 2014 15:03:22 -0800
Subject: [PATCH 1/1] clk: samsung: Remove unneeded semicolon
In-Reply-To: <1389958552-15889-1-git-send-email-sachin.kamat@linaro.org>
References: <1389958552-15889-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140117230322.4167.66838@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sachin Kamat (2014-01-17 03:35:52)
> Semicolon not needed after switch statement.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/samsung/clk-pll.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index f2372fca0136..8538ffe042ce 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -375,7 +375,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
>                 break;
>         default:
>                 break;
> -       };
> +       }
>  
>         /* Set new configuration. */
>         __raw_writel(con1, pll->con_reg + 0x4);
> -- 
> 1.7.9.5
> 
