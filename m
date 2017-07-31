From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:37 +0200
Subject: [PATCH 06/10] ARM: shmobile: defconfig: Enable DMA for serial ports
In-Reply-To: <cover.1501511664.git.horms+renesas@verge.net.au>
References: <cover.1501511664.git.horms+renesas@verge.net.au>
Message-ID: <01b274b46468d56a036a024f9f04d709bcddd8f5.1501511664.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

DMA for (H)SCIF(A|B) serial ports on R-Car Gen2 and RZ/G1 SoCs is
considered stable, hence enable it by default.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 378f6066ea70..e9cc8a557e80 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -107,6 +107,7 @@ CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SERIAL_SH_SCI_DMA=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_DEMUX_PINCTRL=y
-- 
2.1.4
