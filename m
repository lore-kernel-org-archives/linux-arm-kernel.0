From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:52 +0200
Subject: [PATCH 4/7] ARM: shmobile: defconfig: Enable support for RZN1D-DB
In-Reply-To: <cover.1532086504.git.horms+renesas@verge.net.au>
References: <cover.1532086504.git.horms+renesas@verge.net.au>
Message-ID: <ca4a413075efe2061ceba6eb6a6a61179399bf82.1532086504.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable support for the Renesas RZN1D-DB Board:
  - RZ/N1D (R9A06G032) base SoC support,
  - Synopsys DesignWare 8250 serial port support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index a08d0bcdca75..7a5a970420b6 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -22,6 +22,7 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7792=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_R9A06G032=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
@@ -88,6 +89,7 @@ CONFIG_INPUT_ADXL34X=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_I2C_CHARDEV=y
-- 
2.11.0
