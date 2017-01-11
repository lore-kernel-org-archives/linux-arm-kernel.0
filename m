From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed, 11 Jan 2017 18:14:10 +0800
Subject: [PATCH v2 2/3] MAINTAINERS: add zx2967 thermal drivers to ARM ZTE
 architecture
In-Reply-To: <1484129651-17531-1-git-send-email-baoyou.xie@linaro.org>
References: <1484129651-17531-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1484129651-17531-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zx2967 thermal drivers as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64f04df..2593296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1981,6 +1981,7 @@ S:	Maintained
 F:	arch/arm/mach-zx/
 F:	drivers/clk/zte/
 F:	drivers/soc/zte/
+F:	drivers/thermal/zx*
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
-- 
2.7.4
