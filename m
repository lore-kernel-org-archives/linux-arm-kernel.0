From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 8 Aug 2015 07:39:00 +0530
Subject: [PATCH v3] cpufreq-dt: make scaling_boost_freqs sysfs attr
 available when boost is enabled
In-Reply-To: <2130756.euuUs9t9I5@amdc1976>
References: <2130756.euuUs9t9I5@amdc1976>
Message-ID: <20150808020900.GN6939@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:59, Bartlomiej Zolnierkiewicz wrote:
> Make scaling_boost_freqs sysfs attribute is available when
> cpufreq-dt driver is used and boost support is enabled.
> 
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2: Removed leftover prototype.
> v3: added missing Acked-by
> Sorry for two resends, this is not my day..
> Rafael, please apply for v4.3.

Yeah, please apply only this patch from the series.

-- 
viresh
