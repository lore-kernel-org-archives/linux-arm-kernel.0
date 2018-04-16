From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:39:59 -0300
Subject: [PATCH 4/7] arm64: defconfig: Enable HID over I2C drivers
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-5-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the HID-I2C driver to support the stylus
present in RK3399 Kevin Chromebooks.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 397bc0b42a86..9b12f0ea0e35 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -443,6 +443,7 @@ CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SIMPLE_CARD=y
+CONFIG_I2C_HID=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.16.3
