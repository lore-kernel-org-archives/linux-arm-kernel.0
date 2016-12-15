From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2016 00:03:57 +0100
Subject: [GIT PULL 4/7] ARM: SoC 64-bit changes for v4.10
In-Reply-To: <2664636.Hf0nvRznEK@wuerfel>
References: <2664636.Hf0nvRznEK@wuerfel>
Message-ID: <6106200.yGGmYWpirc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:

  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-arm64

for you to fetch changes up to 2e50f79484d917434c25b0bf26481eb917936de6:

  Merge tag 'v4.10-rockchip-defconfig64' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/arm64 (2016-11-30 23:05:53 +0100)

----------------------------------------------------------------
ARM: SoC 64-bit changes for v4.9

Changes to platform code for 64-bit ARM platforms. We are not adding
any new platforms that require code or Kconfig changes this time, so
it's basically just defconfig changes to enable support for more
drivers used on the existing platforms.

This is mainly interesting for the Raspberry Pi 3, which should
now work much better with the default build.

----------------------------------------------------------------
Andy Yan (2):
      arm64: defconfig: enable I2C and DW MMC controller on rockchip platform
      arm64: defconfig: enable RK808 components

Arnd Bergmann (3):
      Merge tag 'arm-soc/for-4.10/maintainers-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'arm-soc/for-4.10/defconfig-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'v4.10-rockchip-defconfig64' of git://git.kernel.org/.../mmind/linux-rockchip into next/arm64

Catalin Marinas (1):
      arm64: Enable HIBERNATION in defconfig

Eric Anholt (1):
      arm64: Add BCM2835 (Raspberry Pi 3) support to the defconfig

Florian Fainelli (2):
      Merge tag 'bcm2835-defconfig-64-next-2016-09-22' into defconfig-arm64/next
      Merge tag 'bcm2835-defconfig-64-next-2016-11-18' into defconfig-arm64/next

Geert Uytterhoeven (1):
      arm64: defconfig: Do not lower CONFIG_LOG_BUF_SHIFT

Heiko Stuebner (1):
      arm64: defconfig: allow rk3399-based boards to boot from mmc and usb

Jayachandran C (1):
      MAINTAINERS: Update Broadcom Vulcan maintainer email

Jeremy McNicoll (1):
      arm64: configs: enable configs for msm899(2/4) basic support

Joseph Lo (1):
      arm64: defconfig: Enable Tegra186 SoC

Linus Walleij (1):
      arm64: defconfig: drop GPIO_SYSFS on multiplatforms

Magnus Damm (1):
      arm64: defconfig: Enable DRM DU and V4L2 FCP + VSP modules

Martin Sperl (1):
      ARM64: bcm2835: add thermal driver to default config

Michael Scott (1):
      arm64: qcom: enable GPIOLIB in Kconfig

Neil Armstrong (3):
      ARM64: defconfig: Enable MMC related configs
      ARM64: configs: Add Platform MHU in defconfig
      ARM64: configs: Activate Internal PHY for Meson GXL

Olof Johansson (5):
      Merge tag 'renesas-arm64-defconfig-for-v4.10' of git://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'qcom-arm64-defconfig-for-4.10' of git://git.kernel.org/.../agross/linux into next/arm64
      Merge tag 'qcom-soc-for-4.10' of git://git.kernel.org/.../agross/linux into next/arm64
      Merge tag 'amlogic-defconfig' of git://git.kernel.org/.../khilman/linux-amlogic into next/arm64
      Merge tag 'tegra-for-4.10-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into next/arm64

Scott Branden (1):
      arm64: defconfig: enable EEPROM_AT25 config option

 MAINTAINERS                  |  2 +-
 arch/arm64/Kconfig.platforms |  1 +
 arch/arm64/configs/defconfig | 56 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 3 deletions(-)
