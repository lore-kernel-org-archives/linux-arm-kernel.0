From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:29:07 +0530
Subject: [PATCH 001/228] cpufreq: Remove extra blank line
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <527549804685f2fe723d0b6b7d60324ac6790771.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need a blank line just at start of a block, lets remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 005eb73..3d5e6d6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1240,7 +1240,6 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 		if (!frozen)
 			sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
-
 		new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
 		if (new_cpu >= 0) {
 			WARN_ON(lock_policy_rwsem_write(cpu));
-- 
1.7.12.rc2.18.g61b472e
