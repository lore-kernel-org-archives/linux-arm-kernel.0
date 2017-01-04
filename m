From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed,  4 Jan 2017 19:48:11 +0800
Subject: [PATCH v6 2/5] MAINTAINERS: add zx2967 SoC drivers to ARM ZTE
 architecture
In-Reply-To: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
References: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1483530494-14177-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ZTE SoC drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

By the way, this patch adds the maintainer for ARM
ZTE architecture to Baoyou Xie.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad199da..2593296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1975,12 +1975,17 @@ F:	arch/arm/mach-pxa/include/mach/z2.h
 
 ARM/ZTE ARCHITECTURE
 M:	Jun Nie <jun.nie@linaro.org>
+M:	Baoyou Xie <baoyou.xie@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/soc/zte/
+F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
-- 
2.7.4
