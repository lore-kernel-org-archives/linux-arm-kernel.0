From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu, 16 Feb 2017 14:00:43 +0800
Subject: [PATCH v7 2/3] MAINTAINERS: add zx2967 i2c controller driver to ARM
 ZTE architecture
In-Reply-To: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
References: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1487224844-10973-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 i2c controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..313fab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,9 +1987,11 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/i2c/busses/i2c-zx2967.c
 F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-zx2967.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	include/dt-bindings/soc/zx*.h
 
-- 
2.7.4
