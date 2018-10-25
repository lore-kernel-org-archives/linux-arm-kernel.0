From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Thu, 25 Oct 2018 17:09:32 +0200
Subject: [PATCH v1 3/4] ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1540480173-12009-4-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_TOUCHSCREEN_GOODIX so that we can have functional touch
screen by default on Digi International's AUO/Goodix LCD accessory kit used
with the ConnectCore 6UL SBC Pro (ccimx6ulsbcpro) board.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 7eca43ff69bb..d6e947307d67 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -170,6 +170,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_TOUCHSCREEN_EGALAX=y
+CONFIG_TOUCHSCREEN_GOODIX=y
 CONFIG_TOUCHSCREEN_MAX11801=y
 CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
 CONFIG_TOUCHSCREEN_EDT_FT5X06=y
