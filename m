From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Wed, 15 Feb 2017 18:55:09 +0800
Subject: [PATCH v1 2/3] MAINTAINERS: add zte 96p22 controller driver to ARM
 ZTE architecture
In-Reply-To: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1487156110-12840-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the zte 96p22 controller driver as maintained by ARM ZTE
architecture maintainers, as they're parts of the core IP.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63063b..8146377 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1991,7 +1991,9 @@ F:	drivers/soc/zte/
 F:	Documentation/devicetree/bindings/arm/zte.txt
 F:	Documentation/devicetree/bindings/clock/zx296702-clk.txt
 F:	Documentation/devicetree/bindings/soc/zte/
+F:	Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
 F:	include/dt-bindings/soc/zx*.h
+F:	sound/soc/codecs/zx_aud96p22.c
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
-- 
2.7.4
