From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 23 Jun 2017 17:40:14 +0200
Subject: [PATCH 2/2] arm64: defconfig: enable nop-xceiv PHY driver
In-Reply-To: <20170623154014.20573-1-thomas.petazzoni@free-electrons.com>
References: <20170623154014.20573-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170623154014.20573-2-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the nop-xceiv PHY driver, which is needed for USB
support to work on the MacchiatoBin platform (Marvell Armada 8K).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 97c123e..e037f1b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -388,6 +388,7 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MSM_OTG=y
 CONFIG_USB_QCOM_8X16_PHY=y
 CONFIG_USB_ULPI=y
-- 
2.9.4
