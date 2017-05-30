From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 11:16:10 +0200
Subject: [PATCH 5/6] arm64: marvell: enable ICU and GICP drivers
In-Reply-To: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1496135772-20694-6-git-send-email-thomas.petazzoni@free-electrons.com>
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
2.7.4
