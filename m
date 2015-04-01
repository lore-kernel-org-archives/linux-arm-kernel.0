From: zhengjunling@huawei.com (Junling Zheng)
Date: Wed, 1 Apr 2015 13:12:51 +0000
Subject: [PATCH 1/2] ARM: hisi: fix the indentations in Kconfig
In-Reply-To: <1427893972-1121-1-git-send-email-zhengjunling@huawei.com>
References: <1427893972-1121-1-git-send-email-zhengjunling@huawei.com>
Message-ID: <1427893972-1121-2-git-send-email-zhengjunling@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the indentations using tabs instead of spaces to align our code.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 arch/arm/mach-hisi/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 83061ad..a12b764 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -23,12 +23,12 @@ config ARCH_HI3xxx
 	  Support for Hisilicon Hi36xx SoC family
 
 config ARCH_HIP01
-       bool "Hisilicon HIP01 family" if ARCH_MULTI_V7
-       select HAVE_ARM_SCU if SMP
-       select HAVE_ARM_TWD if SMP
-       select ARM_GLOBAL_TIMER
-       help
-         Support for Hisilicon HIP01 SoC family
+	bool "Hisilicon HIP01 family" if ARCH_MULTI_V7
+	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
+	select ARM_GLOBAL_TIMER
+	help
+	  Support for Hisilicon HIP01 SoC family
 
 config ARCH_HIP04
 	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
-- 
1.8.3.4
