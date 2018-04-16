From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:40:02 -0300
Subject: [PATCH 7/7] arm64: defconfig: Enable bluetooth USB support
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-8-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Bluetooth USB controller which is present
in the RK3399 Kevin Chromebook.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 39ac42187f7f..34037d24fbf4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -157,6 +157,7 @@ CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
 CONFIG_BT_LEDS=y
 # CONFIG_BT_DEBUGFS is not set
+CONFIG_BT_HCIBTUSB=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=m
-- 
2.16.3
