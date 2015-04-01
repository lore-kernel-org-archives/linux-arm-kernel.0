From: zhengjunling@huawei.com (Junling Zheng)
Date: Wed, 1 Apr 2015 13:12:52 +0000
Subject: [PATCH 2/2] ARM: hisi: replace a few spaces with tabs
In-Reply-To: <1427893972-1121-1-git-send-email-zhengjunling@huawei.com>
References: <1427893972-1121-1-git-send-email-zhengjunling@huawei.com>
Message-ID: <1427893972-1121-3-git-send-email-zhengjunling@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace a few spaces with tabs in mach-hisi to keep the code style.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 arch/arm/mach-hisi/hotplug.c |  4 ++--
 arch/arm/mach-hisi/platsmp.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index a129aae..8cd314c 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -65,8 +65,8 @@
 #define PMC0_CPU1_PMC_ENABLE		(1 << 7)
 #define PMC0_CPU1_POWERDOWN		(1 << 3)
 
-#define HIP01_PERI9                    0x50
-#define PERI9_CPU1_RESET               (1 << 1)
+#define HIP01_PERI9			0x50
+#define PERI9_CPU1_RESET		(1 << 1)
 
 enum {
 	HI3620_CTRL,
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 8880c8e..808a3a1 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -135,9 +135,9 @@ struct smp_operations hix5hd2_smp_ops __initdata = {
 };
 
 
-#define SC_SCTL_REMAP_CLR      0x00000100
-#define HIP01_BOOT_ADDRESS     0x80000000
-#define REG_SC_CTRL            0x000
+#define SC_SCTL_REMAP_CLR	0x00000100
+#define HIP01_BOOT_ADDRESS	0x80000000
+#define REG_SC_CTRL		0x000
 
 void hip01_set_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
 {
@@ -177,8 +177,8 @@ static int hip01_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 struct smp_operations hip01_smp_ops __initdata = {
-	.smp_prepare_cpus       = hisi_common_smp_prepare_cpus,
-	.smp_boot_secondary     = hip01_boot_secondary,
+	.smp_prepare_cpus	= hisi_common_smp_prepare_cpus,
+	.smp_boot_secondary	= hip01_boot_secondary,
 };
 
 CPU_METHOD_OF_DECLARE(hi3xxx_smp, "hisilicon,hi3620-smp", &hi3xxx_smp_ops);
-- 
1.8.3.4
