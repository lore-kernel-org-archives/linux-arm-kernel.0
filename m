From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  4 Sep 2018 10:57:48 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20
Message-ID: <1536076668-21412-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA DTS updates for v4.20.

Thanks,
Dinh

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.20_part1

for you to fetch changes up to 202eb5481421040e115526b75317b5ca72584806:

  ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,nano_soc} (2018-08-30 08:38:26 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.20
- Rename de0_sockit to de0_nano_soc
- Update NAND clocking
- Set timer interrupt to edge sensitive
- Stratix10 platform updates
  - Update devkit with correct i2c clock

----------------------------------------------------------------
Alan Tull (1):
      arm64: dts: stratix10: i2c clock running out of spec

Dinh Nguyen (2):
      ARM: dts: arria10: update NAND clocking
      ARM: dts: socfpga: update NAND clocking for c5/a5

Marek Vasut (1):
      ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,nano_soc}

Silvan Murer (1):
      ARM: dts: socfpga: set timer interrupt to edge sensitive

Simon Goldschmidt (1):
      ARM: dts: socfpga: use stdout-path for chosen node

 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/socfpga.dtsi                     | 12 ++++++++++--
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 22 +++++++++++++++++++---
 ...ockit.dts => socfpga_cyclone5_de0_nano_soc.dts} |  0
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |  3 ++-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |  3 ++-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  2 ++
 7 files changed, 36 insertions(+), 8 deletions(-)
 rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)
