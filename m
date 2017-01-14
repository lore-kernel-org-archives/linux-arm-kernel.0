From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Sat, 14 Jan 2017 15:05:29 +0800
Subject: [PATCH v1 2/3] MAINTAINERS: add zx2967 reset controller driver to ARM
 ZTE architecture
In-Reply-To: <1484377530-30635-1-git-send-email-baoyou.xie@linaro.org>
References: <1484377530-30635-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484377530-30635-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 reset controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2793808..08f8155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1980,10 +1980,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	Documentation/devicetree/bindings/thermal/zx*
 F:	include/dt-bindings/soc/zx*.h
-- 
2.7.4
