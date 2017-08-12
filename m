From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Sat, 12 Aug 2017 11:10:42 +0530
Subject: [PATCH 2/3] arm64: defconfig: Enable CONFIG_MFD_AXP20X_RSB
In-Reply-To: <1502516443-4740-1-git-send-email-jteki@openedev.com>
References: <1502516443-4740-1-git-send-email-jteki@openedev.com>
Message-ID: <1502516443-4740-2-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

X-Powers AXP series PMICs with RSB is need for sunxi a64
so make it default in defconfig.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 33d2d62..a11fce7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -313,6 +313,7 @@ CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
 CONFIG_MFD_CROS_EC_SPI=y
-- 
2.7.4
