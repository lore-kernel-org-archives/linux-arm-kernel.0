From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 28 Mar 2014 12:07:49 -0700
Subject: [PATCH] clk: Fix minor errors in of_clk_init() function comments
In-Reply-To: <1395918516-23822-1-git-send-email-s.nawrocki@samsung.com>
References: <1395918516-23822-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140328190749.5762.7875@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sylwester Nawrocki (2014-03-27 04:08:36)
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Taken into clk-next.

Thanks,
Mike

> ---
>  drivers/clk/clk.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c859adf..29dc1e7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2575,7 +2575,7 @@ static int parent_ready(struct device_node *np)
>   * @matches: array of compatible values and init functions for providers.
>   *
>   * This function scans the device tree for matching clock providers
> - * and calls their initialization functions. It also do it by trying
> + * and calls their initialization functions. It also does it by trying
>   * to follow the dependencies.
>   */
>  void __init of_clk_init(const struct of_device_id *matches)
> @@ -2612,7 +2612,7 @@ void __init of_clk_init(const struct of_device_id *matches)
>                 }
>  
>                 /*
> -                * We didn't managed to initialize any of the
> +                * We didn't manage to initialize any of the
>                  * remaining providers during the last loop, so now we
>                  * initialize all the remaining ones unconditionally
>                  * in case the clock parent was not mandatory
> -- 
> 1.7.9.5
> 
