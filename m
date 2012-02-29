From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 29 Feb 2012 15:18:13 +0800
Subject: [PATCH 0/2] change lpj in arm smp common code
Message-ID: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two patches were originally in [PATCH V6 0/7] add a generic cpufreq driver.
I seperated them and hope they can go to upstream earlier.

Richard Zhao (2):
  ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
  cpufreq: OMAP: remove loops_per_jiffy recalculate for smp

 arch/arm/kernel/smp.c          |   54 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/omap-cpufreq.c |   36 --------------------------
 2 files changed, 54 insertions(+), 36 deletions(-)

-- 
1.7.5.4
