From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:00:33 +0100
Subject: [PATCH V2 4/4] ARM: shmobile: koelsch: Enable RSPI and MTD_M25P80 in
 defconfig
In-Reply-To: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389524433-2823-5-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This enables support for the Spansion s25fl512s SPI FLASH on QSPI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - No changes

 arch/arm/configs/koelsch_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index f795ea42a8fc..8f283f725a12 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -36,6 +36,8 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
+CONFIG_MTD=y
+CONFIG_MTD_M25P80=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -58,6 +60,8 @@ CONFIG_SH_ETH=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.7.9.5
