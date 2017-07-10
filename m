From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 15:28:18 +0200
Subject: [PATCH 5/9] ARM: shmobile: defconfig: Enable DMA for serial ports
In-Reply-To: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499693302-25120-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA for (H)SCIF(A|B) serial ports on R-Car Gen2 and RZ/G1 SoCs is
considered stable, hence enable it by default.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b8d2dcbc9cc745b6..dd9d1f9ede6e7f34 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -106,6 +106,7 @@ CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SERIAL_SH_SCI_DMA=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_DEMUX_PINCTRL=y
-- 
2.7.4
