From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 May 2013 09:32:06 +0800
Subject: [PATCH 1/3] ARM: imx: include <asm/io.h> in hardware.h
In-Reply-To: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
References: <1368408728-12264-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1368408728-12264-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As IOMEM is referenced in hardware.h, <asm/io.h> should be included
there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/hardware.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 356131f..a3b0b04 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -20,6 +20,7 @@
 #ifndef __ASM_ARCH_MXC_HARDWARE_H__
 #define __ASM_ARCH_MXC_HARDWARE_H__
 
+#include <asm/io.h>
 #include <asm/sizes.h>
 
 #define addr_in_module(addr, mod) \
-- 
1.7.9.5
