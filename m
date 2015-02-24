From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 24 Feb 2015 15:09:24 +0100
Subject: [PATCH] ARM: shmobile: defconfig: Drop useless SERIAL_8250_EXTENDED=y
Message-ID: <1424786964-30977-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SERIAL_8250_EXTENDED only serves as a guard for other Kconfig options,
none of which is enabled in shmobile_defconfig.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index d206041e822a312a..11554158fa96ca9c 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -93,7 +93,6 @@ CONFIG_INPUT_ADXL34X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
-- 
1.9.1
