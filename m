From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Jun 2010 08:45:39 +0200
Subject: [PATCH 1/2] ARM/scoop: Add CPR register bit definitions
Message-ID: <1276238740-10640-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bit definitions of the CPR register of the SCOOP chip into scoop.h

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/include/asm/hardware/scoop.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/scoop.h b/arch/arm/include/asm/hardware/scoop.h
index 46492a6..5821f21 100644
--- a/arch/arm/include/asm/hardware/scoop.h
+++ b/arch/arm/include/asm/hardware/scoop.h
@@ -22,6 +22,11 @@
 #define SCOOP_GPWR 0x24
 #define SCOOP_GPRR 0x28
 
+#define SCOOP_CPR_OUT	( 1 << 7 )
+#define SCOOP_CPR_SD_3V	( 1 << 2 )
+#define SCOOP_CPR_CF_XV	( 1 << 1 )
+#define SCOOP_CPR_CF_3V	( 1 << 0 )
+
 #define SCOOP_GPCR_PA22	( 1 << 12 )
 #define SCOOP_GPCR_PA21	( 1 << 11 )
 #define SCOOP_GPCR_PA20	( 1 << 10 )
-- 
1.7.1
