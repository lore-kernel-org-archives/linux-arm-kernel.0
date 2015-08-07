From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Aug 2015 18:13:10 +0530
Subject: [PATCH v2] cpufreq-dt: make scaling_boost_freqs sysfs attr
 available when boost is enabled
In-Reply-To: <3835403.gWyHpfh1Gz@amdc1976>
References: <3835403.gWyHpfh1Gz@amdc1976>
Message-ID: <20150807124310.GI6939@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-08-15, 13:56, Bartlomiej Zolnierkiewicz wrote:
> Make scaling_boost_freqs sysfs attribute is available when
> cpufreq-dt driver is used and boost support is enabled.
> 
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2: Removed leftover prototype.
> 
>  drivers/cpufreq/cpufreq-dt.c | 9 ++++++++-
>  include/linux/cpufreq.h      | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
