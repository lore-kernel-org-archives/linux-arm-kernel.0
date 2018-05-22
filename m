From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 22 May 2018 11:40:36 +0200
Subject: [PATCH v2 10/16] arm64: marvell: enable SEI driver
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Message-ID: <20180522094042.24770-11-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the newly introduced Marvell SEI driver for the 64-bit Marvell
EBU platforms.

Suggested-by: Haim Boot <hayim@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2b1535cdeb7c..dc3c42938051 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -121,6 +121,7 @@ config ARCH_MVEBU
 	select MVEBU_ICU
 	select MVEBU_ODMI
 	select MVEBU_PIC
+	select MVEBU_SEI
 	select OF_GPIO
 	select PINCTRL
 	select PINCTRL_ARMADA_37XX
-- 
2.14.1
