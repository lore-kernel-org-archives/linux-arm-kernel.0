From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Jun 2017 16:07:21 +0200
Subject: [PATCH v4 5/6] arm64: marvell: enable ICU and GICP drivers
In-Reply-To: <20170620140722.31646-1-thomas.petazzoni@free-electrons.com>
References: <20170620140722.31646-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170620140722.31646-6-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the newly introduced Marvell GICP and ICUs driver
for the 64-bit Marvell EBU platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4afcffc..bf3b505 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -106,6 +106,8 @@ config ARCH_MVEBU
 	select ARMADA_AP806_SYSCON
 	select ARMADA_CP110_SYSCON
 	select ARMADA_37XX_CLK
+	select MVEBU_GICP
+	select MVEBU_ICU
 	select MVEBU_ODMI
 	select MVEBU_PIC
 	help
-- 
2.9.4
