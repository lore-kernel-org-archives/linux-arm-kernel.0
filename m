From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 Aug 2017 10:40:41 +0530
Subject: [PATCH] cpufreq: dt: Add rk3328 compatible to use generic
 cpufreq driver
In-Reply-To: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com>
References: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20170804051041.GB28857@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-08-17, 09:52, Finley Xiao wrote:
> This patch adds the rk3328 compatible string for supporting
> the generic cpufreq driver on RK3328.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 096aea7..13c0c47 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -76,6 +76,7 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "rockchip,rk3188", },
>  	{ .compatible = "rockchip,rk3228", },
>  	{ .compatible = "rockchip,rk3288", },
> +	{ .compatible = "rockchip,rk3328", },
>  	{ .compatible = "rockchip,rk3366", },
>  	{ .compatible = "rockchip,rk3368", },
>  	{ .compatible = "rockchip,rk3399", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
