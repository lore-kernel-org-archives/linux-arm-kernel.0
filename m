From: nm@ti.com (Nishanth Menon)
Date: Thu, 24 Mar 2016 17:52:49 -0500
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Enable DP83867 support
In-Reply-To: <1458859969-14298-1-git-send-email-nm@ti.com>
References: <1458859969-14298-1-git-send-email-nm@ti.com>
Message-ID: <1458859969-14298-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DP83867 Ethernet phy for supporting networking on DRA72-EVM rev C
(SR2.0).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 156bc88b8523..9ce8ea53cf51 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -178,6 +178,7 @@ CONFIG_TI_CPTS=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_AT803X_PHY=y
 CONFIG_SMSC_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_USB_USBNET=m
 CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
-- 
2.8.0.rc3
