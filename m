From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 12:40:05 +0200
Subject: [GIT PULL 4/4] Rockchip arm64 defconfig updates for 4.18 round 1
In-Reply-To: <2000491.bLgWuj0xar@phil>
References: <2000491.bLgWuj0xar@phil>
Message-ID: <2676342.8y6AX4oR9f@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.18-rockchip-defconfig64-1

for you to fetch changes up to 214f2c319a140f8a0121f362ad8e73ea1576d5ad:

  arm64: defconfig: enable rockchip efuse (2018-05-09 16:33:09 +0200)

----------------------------------------------------------------
Enablement of Rockchip-specific efuse, io-domain and typec drivers
as well as general cros-ec, hid, touchscreen bluetooth and wifi-drivers
on 64bit arm platforms.

----------------------------------------------------------------
Enric Balletbo i Serra (3):
      arm64: defconfig: Enable typec-phy and extcon-usbc-cros-ec for rk3399
      arm64: defconfig: Enable Rockchip io-domain driver
      arm64: defconfig: Enable ChromeOS EC drivers for supported Chromebooks.

Ezequiel Garcia (4):
      arm64: defconfig: Enable HID over I2C drivers
      arm64: defconfig: Enable Atmel Maxtouch driver
      arm64: defconfig: Enable Marvell WiFi-Ex PCIe driver
      arm64: defconfig: Enable bluetooth USB support

Heiko Stuebner (1):
      arm64: defconfig: enable rockchip efuse

 arch/arm64/configs/defconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
