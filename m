From: lukma@denx.de (Lukasz Majewski)
Date: Fri, 17 Nov 2017 00:22:37 +0100
Subject: [PATCH 2/4] ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h
 file
In-Reply-To: <20171116232239.16823-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
Message-ID: <20171116232239.16823-3-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds include file guards to ts72xx.h

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/mach-ep93xx/ts72xx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index 2255ba29fdd6..d67f203f769a 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -11,6 +11,9 @@
  * febfd000	22800000	4K	options register #2
  */
 
+#ifndef __TS72XX_H_
+#define __TS72XX_H_
+
 #define TS72XX_MODEL_PHYS_BASE		0x22000000
 #define TS72XX_MODEL_VIRT_BASE		IOMEM(0xfebff000)
 #define TS72XX_MODEL_SIZE		0x00001000
@@ -85,3 +88,4 @@ static inline int is_ts9420_installed(void)
 					TS72XX_OPTIONS2_TS9420);
 }
 #endif
+#endif /* __TS72XX_H_ */
-- 
2.11.0
