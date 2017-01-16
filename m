From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon, 16 Jan 2017 12:19:54 +0800
Subject: [PATCH v1 2/3] MAINTAINERS: add zx2967 watchdog controller driver to
 ARM ZTE architecture
In-Reply-To: <1484540395-3335-1-git-send-email-baoyou.xie@linaro.org>
References: <1484540395-3335-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484540395-3335-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 watchdog controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08f8155..77f0290 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1983,11 +1983,13 @@ F:	drivers/clk/zte/
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx*
+F:	drivers/watchdog/zx2967_wdt.c
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	Documentation/devicetree/bindings/thermal/zx*
+F:	Documentation/devicetree/bindings/watchdog/zte,zx2967-wdt.txt
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4
