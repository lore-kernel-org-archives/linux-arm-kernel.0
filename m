From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 15:28:19 +0200
Subject: [PATCH 6/9] ARM: shmobile: defconfig: Refresh
In-Reply-To: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499693302-25120-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  - Several options were moved,
  - INPUT_MOUSEDEV_PSAUX is no longer enabled by default since commit
    73d8ef76006b649f ("Input: mousedev - stop offering PS/2 to userspace
    by default").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index dd9d1f9ede6e7f34..1cad253c030f4b25 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -89,9 +89,8 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_SMSC_PHY=y
 CONFIG_MICREL_PHY=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_SMSC_PHY=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
@@ -123,9 +122,9 @@ CONFIG_SPI_SH_HSPI=y
 CONFIG_GPIO_EM=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_PCF857X=y
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_RMOBILE=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
-- 
2.7.4
