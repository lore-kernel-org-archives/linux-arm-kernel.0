From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon, 13 Feb 2017 16:17:32 +0800
Subject: [PATCH v1 2/3] MAINTAINERS: add zte tdm controller driver to ARM ZTE
 architecture
In-Reply-To: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
References: <1486973853-25291-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486973853-25291-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zte tdm controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..1269eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1991,7 +1991,9 @@ F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/sound/zte,zx-tdm.txt
 F:	include/dt-bindings/soc/zx*.h
+F:	sound/soc/zte/zx-tdm.c
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
-- 
2.7.4
