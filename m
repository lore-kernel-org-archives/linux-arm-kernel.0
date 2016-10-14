From: niklas.cassel@axis.com (Niklas Cassel)
Date: Fri, 14 Oct 2016 15:08:08 +0200
Subject: [RESEND PATCH 1/3] ARM: ARTPEC-6: add select MFD_SYSCON to
 MACH_ARTPEC6
Message-ID: <1476450488-4511-1-git-send-email-niklass@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas Cassel <niklas.cassel@axis.com>

Since the ARTPEC-6 machine port already uses syscon,
MACH_ARTPEC6 should select MFD_SYSCON.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/mach-artpec/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-artpec/Kconfig b/arch/arm/mach-artpec/Kconfig
index 6cbe5a2..85a962a 100644
--- a/arch/arm/mach-artpec/Kconfig
+++ b/arch/arm/mach-artpec/Kconfig
@@ -14,6 +14,7 @@ config MACH_ARTPEC6
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
+	select MFD_SYSCON
 	help
 	  Support for Axis ARTPEC-6 ARM Cortex A9 Platform
 
-- 
2.1.4
