From: t.remmet@phytec.de (Teresa Remmet)
Date: Tue, 24 Jan 2017 11:09:35 +0100
Subject: [PATCH v2 2/3] ARM: configs: omap2plus_defconfig: Enable support for
 micrell phys
In-Reply-To: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1485252576-36955-2-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phyCORE-AM335x SoM with PCM-953 carrierboard has a
KSZ9021 phy mounted. To add support for this we need to enable
the micrell phy driver in the config.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 195c98b..0c2bf2d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -168,6 +168,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
+CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
-- 
1.9.1
