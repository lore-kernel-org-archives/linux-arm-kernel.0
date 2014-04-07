From: denis@eukrea.com (Denis Carikli)
Date: Mon,  7 Apr 2014 18:04:01 +0200
Subject: [PATCH v2][ 3/3] ARM: imx_v6_v7_defconfig: Enable drivers for i.MX51
 USB Host support.
In-Reply-To: <1396886641-26985-1-git-send-email-denis@eukrea.com>
References: <1396886641-26985-1-git-send-email-denis@eukrea.com>
Message-ID: <1396886641-26985-3-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- Rebased.
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ca9f59a..5129f01 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -209,8 +209,10 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_OTG_FSM=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
+CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=y
 CONFIG_MMC=y
-- 
1.7.9.5
