From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Tue, 10 Aug 2010 14:10:05 +0530
Subject: [PATCH] ARM: Fix broken Kconfig in arch/arm
In-Reply-To: <no>
References: <no>
Message-ID: <1281429605-29056-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 232f0c7..684c1a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1184,8 +1184,8 @@ config LOCAL_TIMERS
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
-		ARCH_U8500 || ARCH_TEGRA
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_TEGRA)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
-- 
1.6.6.1
