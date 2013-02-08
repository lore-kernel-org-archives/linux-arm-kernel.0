From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  8 Feb 2013 13:36:43 -0200
Subject: [PATCH 3/3] ARM: mxs_defconfig: Build CONFIG_INPUT_EVDEV as built-in
In-Reply-To: <1360337803-19858-1-git-send-email-festevam@gmail.com>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
Message-ID: <1360337803-19858-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Build CONFIG_INPUT_EVDEV as a built-in driver, as it makes easier to test 
the LRADC touchscreen driver, for example, by using the 'evtest' tool.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 7bf5351..2c1329d 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -67,7 +67,7 @@ CONFIG_USB_NET_SMSC95XX=y
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_EVDEV=m
+CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
-- 
1.7.9.5
