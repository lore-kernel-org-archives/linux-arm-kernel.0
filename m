From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 11:44:36 +0530
Subject: [PATCH 02/13] clk: core: remove dead code paths
In-Reply-To: <1334192572-12499-3-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-3-git-send-email-mturquette@linaro.org>
Message-ID: <4F8672CC.2040500@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2012 6:32 AM, Mike Turquette wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 3ed36d3..4daacf5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -194,7 +194,7 @@ static int __init clk_debug_init(void)
>  late_initcall(clk_debug_init);
>  #else
>  static inline int clk_debug_register(struct clk *clk) { return 0; }
> -#endif /* CONFIG_COMMON_CLK_DEBUG */
> +#endif

Why is this updated? Isn't this considered good practice anymore?

-- 
viresh
