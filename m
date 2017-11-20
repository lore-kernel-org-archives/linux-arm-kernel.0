From: shile.zhang@nokia-sbell.com (Shile Zhang)
Date: Mon, 20 Nov 2017 10:34:37 +0800
Subject: [PATCH v1] arm: fix the spacing/tabbing issue
In-Reply-To: <1510910417-9610-1-git-send-email-shile.zhang@nokia-sbell.com>
References: <1510910417-9610-1-git-send-email-shile.zhang@nokia-sbell.com>
Message-ID: <1511145277-18829-1-git-send-email-shile.zhang@nokia-sbell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To fix the style issue where spaces where used instead of tabs.

Signed-off-by: Shile Zhang <shile.zhang@nokia-sbell.com>
---
 add more missed lines' fix.
 Thanks!

 arch/arm/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d1346a1..3728e7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -220,7 +220,7 @@ config ZONE_DMA
 	bool
 
 config NEED_DMA_MAP_STATE
-       def_bool y
+	def_bool y
 
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
@@ -1134,9 +1134,9 @@ config ARM_ERRATA_764369
 	  in the diagnostic control register of the SCU.
 
 config ARM_ERRATA_775420
-       bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
-       depends on CPU_V7
-       help
+	bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
+	depends on CPU_V7
+	help
 	 This option enables the workaround for the 775420 Cortex-A9 (r2p2,
 	 r2p6,r2p8,r2p10,r3p0) erratum. In case a date cache maintenance
 	 operation aborts with MMU exception, it might cause the processor
@@ -1697,12 +1697,12 @@ config HW_PERF_EVENTS
 	depends on ARM_PMU
 
 config SYS_SUPPORTS_HUGETLBFS
-       def_bool y
-       depends on ARM_LPAE
+	def_bool y
+	depends on ARM_LPAE
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
-       def_bool y
-       depends on ARM_LPAE
+	def_bool y
+	depends on ARM_LPAE
 
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
-- 
2.6.2
