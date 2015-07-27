From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 14:07:54 +0530
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150727083754.GD31611@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-07-15, 17:43, Bartlomiej Zolnierkiewicz wrote:
> diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
> index 0414009..483ca1b 100644
> --- a/include/linux/cpufreq-dt.h
> +++ b/include/linux/cpufreq-dt.h
> @@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
>  	 * clock.
>  	 */
>  	bool independent_clocks;
> +	bool boost_supported;
>  };

I am planning to kill this structure soon, don't add anything to it.
We should be doing this based on DT.

-- 
viresh
