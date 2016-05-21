From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:52:11 +0200
Subject: [PATCH 0122/1529] Fix typo
Message-ID: <20160521115211.5758-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-w90x900/include/mach/regs-ldm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-w90x900/include/mach/regs-ldm.h b/arch/arm/mach-w90x900/include/mach/regs-ldm.h
index e9d480a..cb0bd95 100644
--- a/arch/arm/mach-w90x900/include/mach/regs-ldm.h
+++ b/arch/arm/mach-w90x900/include/mach/regs-ldm.h
@@ -229,7 +229,7 @@ enum LCM_DEV_CTRL_DE_POL {
 /* Hardware cursor control Register */
 #define REG_LCM_HC_CTRL			(0x6C)
 
-/* Hardware cursot tip point potison on va picture */
+/* Hardware cursor tip point potison on va picture */
 #define REG_LCM_HC_POS			(0x70)
 
 /* Hardware Cursor Window Buffer Control Register */
-- 
2.8.2.534.g1f66975
