From: joe@perches.com (Joe Perches)
Date: Sun, 07 Nov 2010 13:10:15 -0800
Subject: [PATCH] arch/arm/plat-mxc/cpufreq.c: Fix line continuation defect
Message-ID: <1289164215.29216.315.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/plat-mxc/cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index 039538e..9f358af 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -154,8 +154,8 @@ static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
 	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
 
 	if (ret < 0) {
-		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq \
-				with error code %d\n", __func__, ret);
+		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
+		       __func__, ret);
 		goto err;
 	}
 
