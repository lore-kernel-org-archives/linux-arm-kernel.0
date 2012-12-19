From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:06 +0100
Subject: [PATCH 8/8] arm: mxs: Enable most commonly used PHYs
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-9-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PHY drivers for mostly commonly used ethernet PHYs on MX28
designs.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 2948fec..9d30a6b 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -66,6 +66,10 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_ENC28J60=y
+CONFIG_SMSC_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_MICREL_PHY=y
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
-- 
1.7.10.4
