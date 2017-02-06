From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon,  6 Feb 2017 11:26:08 +0800
Subject: [PATCH v4 2/3] MAINTAINERS: add zx2967 i2c controller driver to ARM
 ZTE architecture
In-Reply-To: <1486351569-4814-1-git-send-email-baoyou.xie@linaro.org>
References: <1486351569-4814-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486351569-4814-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 i2c controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fb9b62..4e81e2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,10 +1987,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	include/dt-bindings/soc/zx*.h
-- 
2.7.4
