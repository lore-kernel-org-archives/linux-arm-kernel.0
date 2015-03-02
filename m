From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Mon, 2 Mar 2015 15:22:19 +0800
Subject: [PATCH 1/2] arm: hisi: drop extern hip01_cpu_die
Message-ID: <1425280939-6204-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the hip01 doesn't support cpu hotplug now, and doesn't implement
the hip01_cpu_die function, drop the declaration.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mach-hisi/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index 92a682d..b89adb4 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -19,5 +19,4 @@ extern void hix5hd2_cpu_die(unsigned int cpu);
 
 extern struct smp_operations hip01_smp_ops;
 extern void hip01_set_cpu(int cpu, bool enable);
-extern void hip01_cpu_die(unsigned int cpu);
 #endif
-- 
1.7.12.4
