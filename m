From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 30 Mar 2015 16:40:15 +0200
Subject: [PATCH 3/4] ARM: multi_v7_defconfig: Build the Marvell WiFi-Ex driver
 as a module
In-Reply-To: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1427726418-3806-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1427726418-3806-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Needed in several Chromebook models such as the Tegra-based ones.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5b4d1c8..7ffa4aa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -133,6 +133,9 @@ CONFIG_CAN_BCM=y
 CONFIG_CAN_DEV=y
 CONFIG_CAN_XILINXCAN=y
 CONFIG_CAN_MCP251X=y
+CONFIG_BT=m
+CONFIG_BT_MRVL=m
+CONFIG_BT_MRVL_SDIO=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_RFKILL=y
@@ -200,6 +203,8 @@ CONFIG_USB_NET_SMSC95XX=y
 CONFIG_BRCMFMAC=m
 CONFIG_RT2X00=m
 CONFIG_RT2800USB=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
-- 
2.1.0
