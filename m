From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:22 +0200
Subject: [PATCH 1/1] arm64: defconfig: Enable BD9571MWV regulator
In-Reply-To: <cover.1532080241.git.horms+renesas@verge.net.au>
References: <cover.1532080241.git.horms+renesas@verge.net.au>
Message-ID: <83c05e98f732bfa77830631e8d4403c76cad9b31.1532080241.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dien Pham <dien.pham.ry@renesas.com>

The BD9571 PMIC is present on the Renesas Salvator-X(S) and R-Car
Starter Kit Premier/Pro development boards.

Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3cfa8ca26738..85ce8f24cdbe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -383,6 +383,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
@@ -396,6 +397,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_REGULATOR_AXP20X=y
+CONFIG_REGULATOR_BD9571MWV=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.11.0
