From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon,  2 Jul 2018 09:05:38 -0500
Subject: [GIT PULL] SoCFPGA updates for v4.19, part1
Message-ID: <1530540338-27657-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA updates for v4.19. The reason it's based on
v4.18-rc3 is that there are some dependencies on fixes that went into
v4.18-rc2.

Thanks,
Dinh

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.19_part1

for you to fetch changes up to 70455ac7ffb6b707af1e56e1993af82906fddaae:

  arm64: dts: stratix10: Add SPI node clocks for Stratix10 (2018-07-02 08:44:15 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.19
- Add SPI node for Arria10
- Stratix10 platform updates
  - Add QSPI support on devkit
  - Add clocks for SPI/USB/watchdog
  - Add additional OCP reset property

----------------------------------------------------------------
Dinh Nguyen (2):
      arm64: dts: stratix10: fill in clocks field for usb and watchdog
      arm64: dts: stratix10: add OCP reset property for ethernet

Thor Thayer (3):
      arm64: dts: stratix10: Add QSPI support for Stratix10
      ARM: dts: Add SPI0 node for Arria10
      arm64: dts: stratix10: Add SPI node clocks for Stratix10

 arch/arm/boot/dts/socfpga_arria10.dtsi             | 12 +++++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 41 ++++++++++++++++++----
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 35 ++++++++++++++++++
 3 files changed, 82 insertions(+), 6 deletions(-)
