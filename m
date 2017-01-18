From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 18 Jan 2017 13:57:10 +0800
Subject: [PATCH RESEND] arm: hisi: drop extern hip01_cpu_die
Message-ID: <1484719030-34755-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the hip01 doesn't support cpu hotplug now, and doesn't implement
the hip01_cpu_die function, drop the declaration.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/mach-hisi/core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index e883583..c58b68a 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -15,5 +15,4 @@
 extern void hix5hd2_cpu_die(unsigned int cpu);
 
 extern void hip01_set_cpu(int cpu, bool enable);
-extern void hip01_cpu_die(unsigned int cpu);
 #endif
-- 
1.7.12.4
