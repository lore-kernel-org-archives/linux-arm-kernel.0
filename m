From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:40:00 -0300
Subject: [PATCH 5/7] arm64: defconfig: Enable Atmel Maxtouch driver
In-Reply-To: <20180416144002.15569-1-ezequiel@collabora.com>
References: <20180416144002.15569-1-ezequiel@collabora.com>
Message-ID: <20180416144002.15569-6-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Atmel Maxtouch driver to support the touchscreen
and touchpad present in RK3399 Kevin Chromebooks.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9b12f0ea0e35..83856a047af9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -253,6 +253,8 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_ADC=m
 CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_HISI_POWERKEY=y
-- 
2.16.3
