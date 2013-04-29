From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Apr 2013 18:54:43 +0530
Subject: [PATCH 0/5] CPUFreq: ARM big LITTLE Fixes
Message-ID: <cover.1367241503.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

I know I am late for this merge window and you have already closed the gates :)
If you can still take them, its good, otherwise we will push this for v3.10-rc2.

These are minor fixes for ARM big LITTLE cpufreq driver. It doesn't impact any
other driver or cpufreq core and are fairly independent.

Viresh Kumar (5):
  cpufreq: ARM big LITTLE: Select PM_OPP
  cpufreq: ARM big LITTLE DT: Return correct transition latency
  cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency
    isn't found
  cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
  cpufreq: ARM big LITTLE: Improve print message

 drivers/cpufreq/Kconfig.arm         | 1 +
 drivers/cpufreq/arm_big_little.c    | 7 +------
 drivers/cpufreq/arm_big_little.h    | 5 +++++
 drivers/cpufreq/arm_big_little_dt.c | 9 +++++----
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.7.12.rc2.18.g61b472e
