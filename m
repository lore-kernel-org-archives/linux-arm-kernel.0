From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 18:17:29 -0200
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable USB_ANNOUNCE_NEW_DEVICES
In-Reply-To: <20181125201729.19836-1-otavio@ossystems.com.br>
References: <20181125201729.19836-1-otavio@ossystems.com.br>
Message-ID: <20181125201729.19836-3-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas M?ller <schnitzeltony@gmail.com>

This is very helpful debugging USB issues.

Signed-off-by: Andreas M?ller <schnitzeltony@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 22ad2d7a1cf2..d339913845fa 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -305,6 +305,7 @@ CONFIG_SND_SOC_WM8962=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
-- 
2.19.1
