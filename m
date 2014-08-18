From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Aug 2014 11:36:16 -0500
Subject: [PATCH] cpuidle: big.LITTLE: add Exynos5800 compatible string
In-Reply-To: <1407888665-24603-1-git-send-email-khilman@linaro.org>
References: <1407888665-24603-1-git-send-email-khilman@linaro.org>
Message-ID: <53F22B80.3050205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/14 19:11, Kevin Hilman wrote:
> Exynos 5800 is big.LITTLE SoC compatible with the 5420.  Add the
> compatible string so this driver works on the 5800.
>
> Tested on exynos5800-peach-pi (aka Samsung Chromebook2)
>
> Signed-off-by: Kevin Hilman<khilman@linaro.org>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks,
Kukjin

> ---
>   drivers/cpuidle/cpuidle-big_little.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index 0a1f827308db..bf3ab66fdaaf 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -166,6 +166,7 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int match_id)
>   static const struct of_device_id compatible_machine_match[] = {
>   	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
>   	{ .compatible = "samsung,exynos5420" },
> +	{ .compatible = "samsung,exynos5800" },
>   	{},
>   };
>
