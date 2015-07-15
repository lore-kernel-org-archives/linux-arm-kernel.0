From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 15 Jul 2015 08:29:22 +0530
Subject: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2
 bindings
In-Reply-To: <3095426.xc9msIINgb@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
 <3095426.xc9msIINgb@amdc1976>
Message-ID: <20150715025922.GD18084@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-07-15, 18:13, Bartlomiej Zolnierkiewicz wrote:
> I believe that following patches:
> 
> * [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
>   (http://lkml.org/lkml/2015/7/9/420)
> 
> * [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
>   (http://lkml.org/lkml/2015/7/9/421)
> 
> should be integrated into this patch series before patch #10 (the current
> one) can be applied.

Hi Bartlomiej,

I haven't tried for the complete support yet, I will take care of
boost frequencies as well, but not in this series.

-- 
viresh
