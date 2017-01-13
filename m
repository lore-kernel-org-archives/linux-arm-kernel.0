From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Fri, 13 Jan 2017 18:46:57 +0800
Subject: [PATCH v4 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE
 architecture
In-Reply-To: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
References: <1484304418-17489-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484304418-17489-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f04df..2793808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,9 +1981,11 @@ S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/thermal/zx*
 F:	include/dt-bindings/soc/zx*.h
 
 ARM/ZYNQ ARCHITECTURE
-- 
2.7.4
