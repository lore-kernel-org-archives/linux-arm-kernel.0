From: david.wu@rock-chips.com (David Wu)
Date: Wed,  9 Aug 2017 20:07:45 +0800
Subject: [PATCH v4 02/12] multi_v7_defconfig: Make rockchip phy built-in
In-Reply-To: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502280475-736-3-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the rockchip phy for multi_v7_defconfig builds.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4d19c1b..94d7e71 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -270,6 +270,7 @@ CONFIG_ICPLUS_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_MICREL_PHY=y
 CONFIG_FIXED_PHY=y
+CONFIG_ROCKCHIP_PHY=y
 CONFIG_USB_PEGASUS=y
 CONFIG_USB_RTL8152=m
 CONFIG_USB_USBNET=y
-- 
1.9.1
