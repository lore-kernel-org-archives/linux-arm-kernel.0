From: shile.zhang@nokia-sbell.com (Shile Zhang)
Date: Fri, 17 Nov 2017 17:20:17 +0800
Subject: [PATCH] arm: fix the spacing/tabbing issue
Message-ID: <1510910417-9610-1-git-send-email-shile.zhang@nokia-sbell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To fix the style issue where spaces where used instead of tabs.

Signed-off-by: Shile Zhang <shile.zhang@nokia-sbell.com>
---
 arch/arm/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c98..d5ee446 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1696,12 +1696,12 @@ config HW_PERF_EVENTS
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
