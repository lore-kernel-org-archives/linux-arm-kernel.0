From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 02 May 2013 23:19:53 +0200
Subject: [PATCH 0/5] CPUFreq: ARM big LITTLE Fixes
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Message-ID: <5220775.R7TYxWOgo3@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 29, 2013 06:54:43 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> I know I am late for this merge window and you have already closed the gates :)
> If you can still take them, its good, otherwise we will push this for v3.10-rc2.
> 
> These are minor fixes for ARM big LITTLE cpufreq driver. It doesn't impact any
> other driver or cpufreq core and are fairly independent.
> 
> Viresh Kumar (5):
>   cpufreq: ARM big LITTLE: Select PM_OPP
>   cpufreq: ARM big LITTLE DT: Return correct transition latency
>   cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency
>     isn't found
>   cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
>   cpufreq: ARM big LITTLE: Improve print message
> 
>  drivers/cpufreq/Kconfig.arm         | 1 +
>  drivers/cpufreq/arm_big_little.c    | 7 +------
>  drivers/cpufreq/arm_big_little.h    | 5 +++++
>  drivers/cpufreq/arm_big_little_dt.c | 9 +++++----
>  4 files changed, 12 insertions(+), 10 deletions(-)

All 5 queued up for the v3.10-rc2 push.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
