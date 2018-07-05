From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  5 Jul 2018 14:40:05 +0200
Subject: [PATCH v4 08/14] arm64: marvell: enable SEI driver
In-Reply-To: <20180705124011.7661-1-miquel.raynal@bootlin.com>
References: <20180705124011.7661-1-miquel.raynal@bootlin.com>
Message-ID: <20180705124011.7661-9-miquel.raynal@bootlin.com>
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
index d5aeac351fc3..67086a8a8307 100644
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
