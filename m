From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 23 Apr 2014 19:51:29 +0800
Subject: [PATCH 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
Message-ID: <5357A941.6080809@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set ARCH_NR_GPIO for Hisilicon Soc hip04, which has 4 GPIO
controllers with 32 GPIOs each.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2961627..bb00e65 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1664,6 +1664,7 @@ config ARCH_NR_GPIO
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_SUNXI
 	default 264 if MACH_H4700
+	default 128 if ARCH_HIP04
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
-- 1.7.9.5
