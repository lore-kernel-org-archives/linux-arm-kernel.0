From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:40:01 -0300
Subject: [PATCH 6/7] arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-7-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the wireless network driver to support the WiFi adapter
present in RK3399 Kevin Chromebooks. Note that this also
enables Bluetooth via USB.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 83856a047af9..39ac42187f7f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -247,6 +247,8 @@ CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_NET_PLUSB=m
 CONFIG_USB_NET_MCS7830=m
 CONFIG_BRCMFMAC=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
-- 
2.16.3
