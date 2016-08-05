From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 Aug 2016 16:55:20 +0200
Subject: [PATCH 3/4] arm64: marvell: enable the Marvell PIC driver
In-Reply-To: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1470408921-447-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes sure the driver for the Marvell PIC interrupt
controller (used on Marvell Armada 7K/8K) is enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05..e395d03 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -74,6 +74,7 @@ config ARCH_MVEBU
 	select ARMADA_AP806_SYSCON
 	select ARMADA_CP110_SYSCON
 	select MVEBU_ODMI
+	select MVEBU_PIC
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
-- 
2.7.4
