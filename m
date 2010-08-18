From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Aug 2010 22:58:37 +0900
Subject: [PATCH] ARM: S5PV310: Fix on default ZRELADDR of ARCH_S5PV310
Message-ID: <1282139917-10186-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds default zreladdr of ARCH_S5PV310.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9295110..a7ed21f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1622,7 +1622,8 @@ config ZRELADDR
 	default 0x40008000 if ARCH_STMP378X ||\
 		ARCH_STMP37XX ||\
 		ARCH_SH7372 ||\
-		ARCH_SH7377
+		ARCH_SH7377 ||\
+		ARCH_S5PV310
 	default 0x50008000 if ARCH_S3C64XX ||\
 		ARCH_SH7367
 	default 0x60008000 if ARCH_VEXPRESS
-- 
1.6.2.5
