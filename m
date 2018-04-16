From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Mon, 16 Apr 2018 11:39:55 -0300
Subject: [PATCH 0/7] Defconfig updates for RK3399
Message-ID: <20180416144002.15569-1-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series collects some pending defconfig patches
from Enric, namely:

https://patchwork.kernel.org/patch/10302033/
https://patchwork.kernel.org/patch/10247583/
https://patchwork.kernel.org/patch/10269255/

And adds some more defconfig changes, required to
support other peripherals:

 * Touchscreen, touchpad and stylus
 * WiFi and Bluetooth

Series tested on RK3399 Kevin Chromebook.

Enric Balletbo i Serra (3):
  arm64: defconfig: Enable typec-phy and extcon-usbc-cros-ec for rk3399
  arm64: defconfig: Enable Rockchip io-domain driver
  arm64: defconfig: Enable ChromeOS EC drivers for supported
    Chromebooks.

Ezequiel Garcia (4):
  arm64: defconfig: Enable HID over I2C drivers
  arm64: defconfig: Enable Atmel Maxtouch driver
  arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
  arm64: defconfig: Enable bluetooth USB support

 arch/arm64/configs/defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.16.3
