From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 02 Aug 2013 20:32:30 -0700
Subject: [PATCH v1 01/14] clk: fixed-rate: Export clk_fixed_rate_register()
In-Reply-To: <1374713022-6049-2-git-send-email-sboyd@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130803033230.6450.51696@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-07-24 17:43:29)
> Export this symbol so that modules can register fixed rate
> clocks.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/clk-fixed-rate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> index dc58fbd..1ed591a 100644
> --- a/drivers/clk/clk-fixed-rate.c
> +++ b/drivers/clk/clk-fixed-rate.c
> @@ -80,6 +80,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
>  
>         return clk;
>  }
> +EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
>  
>  #ifdef CONFIG_OF
>  /**
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
