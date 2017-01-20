From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Fri, 20 Jan 2017 16:43:46 +0800
Subject: [PATCH v1 2/3] MAINTAINERS: add zx2967 i2c controller driver to ARM
 ZTE architecture
In-Reply-To: <1484901827-16369-1-git-send-email-baoyou.xie@linaro.org>
References: <1484901827-16369-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484901827-16369-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 i2c controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 275c434..757c098 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,12 +1987,14 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx*
 F:	drivers/watchdog/zx2967_wdt.c
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	Documentation/devicetree/bindings/thermal/zx*
-- 
2.7.4
