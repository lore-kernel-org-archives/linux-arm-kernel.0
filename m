From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Tue, 17 Jan 2017 11:22:56 +0800
Subject: [PATCH v3 2/3] MAINTAINERS: add zx2967 reset controller driver to ARM
 ZTE architecture
In-Reply-To: <1484623377-16208-1-git-send-email-baoyou.xie@linaro.org>
References: <1484623377-16208-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484623377-16208-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 reset controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..5fb9b62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,9 +1987,11 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
+F:	drivers/reset/reset-zx2967.c
 F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
+F:	Documentation/devicetree/bindings/reset/zte,zx2967-reset.txt
 F:	Documentation/devicetree/bindings/soc/zte/
 F:	include/dt-bindings/soc/zx*.h
 
-- 
2.7.4
