From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  1 Dec 2017 00:51:36 +0100
Subject: [PATCH v4 1/5] ARM: ep93xx: ts72xx: Provide include guards for
 ts72xx.h file
In-Reply-To: <20171130235140.12243-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130235140.12243-1-lukma@denx.de>
Message-ID: <20171130235140.12243-2-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds include file guards to ts72xx.h

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
Changes for v2:
- None
Changes for v3:
- None
Changes for v4:
- None
---
 arch/arm/mach-ep93xx/ts72xx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index 8a3206a54b39..7b7490f10fa9 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -12,6 +12,9 @@
  * febfd000	22800000	4K	options register #2
  */
 
+#ifndef __TS72XX_H_
+#define __TS72XX_H_
+
 #define TS72XX_MODEL_PHYS_BASE		0x22000000
 #define TS72XX_MODEL_VIRT_BASE		IOMEM(0xfebff000)
 #define TS72XX_MODEL_SIZE		0x00001000
@@ -83,3 +86,4 @@ static inline int is_ts9420_installed(void)
 					TS72XX_OPTIONS2_TS9420);
 }
 #endif
+#endif /* __TS72XX_H_ */
-- 
2.11.0
