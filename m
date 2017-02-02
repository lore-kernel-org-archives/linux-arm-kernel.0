From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  2 Feb 2017 23:08:05 +0800
Subject: [PATCH v6 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE
 architecture
In-Reply-To: <1486048086-3431-1-git-send-email-baoyou.xie@linaro.org>
References: <1486048086-3431-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486048086-3431-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fb9b62..edfdea3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1989,10 +1989,12 @@ F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/thermal/zx*
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4
