From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 15:29:09 -0800
Subject: [GIT PULL] Amlogic defconfig changes for v4.10
Message-ID: <7hk2c42ugq.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are some defconfig change for Amlogic family SoCs for 4.10.  Please
pull.

Thanks,

Kevin

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-defconfig

for you to fetch changes up to 88c9cb7c109e8867fd6ac3a11e5cead37a6a6f1d:

  ARM64: configs: Activate Internal PHY for Meson GXL (2016-11-14 08:40:47 -0800)

----------------------------------------------------------------
Amlogic defconfig updates for v4.10
- enable I2C driver
- enable SPI, watchdog and HW random as modules

----------------------------------------------------------------
Neil Armstrong (3):
      ARM64: defconfig: Enable MMC related configs
      ARM64: configs: Add Platform MHU in defconfig
      ARM64: configs: Activate Internal PHY for Meson GXL

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
