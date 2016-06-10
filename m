From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Jun 2016 15:23:29 +0200
Subject: [PATCH 01/10] arm64: marvell: enable Armada 3700 clock drivers
In-Reply-To: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1465565018-14172-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the support for the clocks drivers used on the
Armada 3700.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05859ae..2fdadff9143d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -73,6 +73,7 @@ config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_SYSCON
 	select ARMADA_CP110_SYSCON
+	select ARMADA_37XX_CLK
 	select MVEBU_ODMI
 	help
 	  This enables support for Marvell EBU familly, including:
-- 
2.5.0
