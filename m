From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Aug 2017 10:47:22 +0530
Subject: [PATCH 2/4] cpufreq: enable the DT cpufreq driver on the Ux500
In-Reply-To: <20170810125221.25818-3-linus.walleij@linaro.org>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-3-linus.walleij@linaro.org>
Message-ID: <20170811051722.GF3638@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10-08-17, 14:52, Linus Walleij wrote:
> This enables the generic DT and OPP-based cpufreq driver on the
> ST-Ericsson Ux500 series.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 1c262923fe58..d80300251bc4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -88,6 +88,11 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "socionext,uniphier-ld11", },
>  	{ .compatible = "socionext,uniphier-ld20", },
>  
> +	{ .compatible = "st-ericsson,u8500", },
> +	{ .compatible = "st-ericsson,u8540", },
> +	{ .compatible = "st-ericsson,u9500", },
> +	{ .compatible = "st-ericsson,u9540", },
> +
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap3", },
>  	{ .compatible = "ti,omap4", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
