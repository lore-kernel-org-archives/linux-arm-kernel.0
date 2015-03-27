From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 27 Mar 2015 21:52:31 +0800
Subject: [PATCH v2 2/7] MAINTAINERS: add entry for ARM ZTE architecture
In-Reply-To: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
References: <1427464356-20112-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1427464356-20112-3-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add entry for ZTE ARM architecture

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69cc89f..dc74c16f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1590,6 +1590,15 @@ S:	Maintained
 F:	arch/arm/mach-pxa/z2.c
 F:	arch/arm/mach-pxa/include/mach/z2.h
 
+ARM/ZTE ARCHITECTURE
+M:	Jun Nie <jun.nie@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-zx/
+F:	drivers/clk/zte/
+F:	Documentation/devicetree/bindings/arm/zte.txt
+F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
 R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
-- 
1.9.1
