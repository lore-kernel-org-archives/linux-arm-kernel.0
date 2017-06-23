From: david.wu@rock-chips.com (David Wu)
Date: Fri, 23 Jun 2017 12:42:01 +0800
Subject: [PATCH 03/11] arm64: defconfig: Enable CONFIG_ROCKCHIP_MAC_PHY
In-Reply-To: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1498192929-7519-4-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the rockchip mac phy driver built into the kernel.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 97c123e..b4abe7f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -195,6 +195,7 @@ CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=m
+CONFIG_ROCKCHIP_MAC_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
-- 
1.9.1
