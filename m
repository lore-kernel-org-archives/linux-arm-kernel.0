From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:30 +0000
Subject: [PATCH 2/5] ARM: qcom_defconfig: add usb related configs
In-Reply-To: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536933-21503-3-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index dc27e51..9b2a1f0 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -137,10 +137,16 @@ CONFIG_SND_SOC=y
 CONFIG_HID_BATTERY_STRENGTH=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_OTG=y
 CONFIG_USB_MON=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_ACM=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_UDC=y
+CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_SERIAL=y
+CONFIG_USB_MSM_OTG=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_VBUS_DRAW=500
-- 
2.10.1
