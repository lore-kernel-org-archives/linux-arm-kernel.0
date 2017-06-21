From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 21 Jun 2017 10:35:51 -0500
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.13
Message-ID: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v4.13.

Thanks,
Dinh

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.13

for you to fetch changes up to 000e6f73dcc52d970706010d3bbc74710db4933c:

  ARM: dts: socfpga: set the i2c frequency (2017-05-26 11:19:28 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.13
- Fix clocks node the EMACs
- VINING board updtes
	- Remove I2C EEPROMs and LED node
	- Add QSPI device
	- Add 2nd ethernet alias
- Add 'clock-frequency' binding for i2c node

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: set the i2c frequency

Marek Vasut (6):
      ARM: socfpga: Increase max number of GPIOs
      ARM: dts: socfpga: Fix the ethernet clock phandle
      ARM: dts: socfpga: Enable QSPI support on VINING FPGA
      ARM: dts: socfpga: Remove I2C EEPROMs from VINING FPGA
      ARM: dts: socfpga: Drop LED node from VINING FPGA
      ARM: dts: socfpga: Add second ethernet alias to VINING FPGA

 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/socfpga.dtsi                     |   4 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 101 +++++++++------------
 6 files changed, 47 insertions(+), 65 deletions(-)
