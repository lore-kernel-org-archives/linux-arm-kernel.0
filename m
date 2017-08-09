From: david.wu@rock-chips.com (David Wu)
Date: Wed,  9 Aug 2017 20:07:46 +0800
Subject: [PATCH v4 03/12] arm64: defconfig: Enable CONFIG_ROCKCHIP_PHY
In-Reply-To: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
References: <1502280475-736-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502280475-736-4-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the rockchip phy driver built into the kernel.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147..925bd478 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -203,6 +203,7 @@ CONFIG_MARVELL_PHY=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=m
+CONFIG_ROCKCHIP_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
-- 
1.9.1
