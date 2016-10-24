From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 24 Oct 2016 09:16:54 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.10, part 1
Message-ID: <20161024141654.19832-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof:

Please pull in these DTS updates for SoCFPGA for v4.10.

Thanks,
Dinh

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.10_part_1

for you to fetch changes up to c96f5919e6b0d132aa9afe9f1adc872fc107d5bb:

  ARM: dts: socfpga: socrates: enable qspi (2016-10-18 22:18:14 -0500)

----------------------------------------------------------------
SoCFPGA DTS update for v4.10, part 1
- Add a Macnica sodia board
- Add support for the Arria10 System resource device
- Add support for the Arria10 LEDs
- Add QSPI to the socrates board
- Update L2 cache settings, enabling arm,shared-override

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: enable arm,shared-override in the pl310

Marek Vasut (1):
      ARM: dts: socfpga: Add new MCVEVK manufacturer compat

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: Add Macnica sodia board

Steffen Trumtrar (2):
      ARM: dts: socfpga: add qspi node
      ARM: dts: socfpga: socrates: enable qspi

Thor Thayer (4):
      ARM: dts: socfpga: Add SPI Master1 for Arria10 SR chip
      ARM: dts: socfpga: Add Devkit A10-SR fields for Arria10
      ARM: dts: socfpga: Enable GPIO parent for Arria10 SR chip
      ARM: dts: socfpga: Add LED framework to A10-SR GPIO

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/socfpga.dtsi                  |  15 +++
 arch/arm/boot/dts/socfpga_arria10.dtsi          |  18 ++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |  49 ++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi     |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts   |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts |  19 ++++
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts    | 123 ++++++++++++++++++++++++
 8 files changed, 227 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts
