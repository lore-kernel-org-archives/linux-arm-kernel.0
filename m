From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 10 Oct 2018 10:10:02 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 3, take 2
Message-ID: <20181010151002.10645-1-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these additional patches for v4.20.

Thanks,
Dinh

The following changes since commit 20373e0cb8f7d540ae082a8026f5ae7c27cc6cb3:

  ARM: dts: socfpga: add timer resets for SoCFPGA platform (2018-09-17 10:11:28 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.20_part3

for you to fetch changes up to 2a44d6511a0104e9ff628e73cf4381e5664a8219:

  ARM: dts: socfgpa: remove ethernet aliases from dtsi (2018-10-09 13:40:28 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.20, part 3
- Add ethernet aliases for Stratix10
- Move ethernet aliases from socfpga dtsi
- Correct system manager register size for Stratix10
- Correct SDRAM node address for Arria10

----------------------------------------------------------------
Dinh Nguyen (2):
      arm64: dts: stratix10: add ethernet aliases
      ARM: dts: socfgpa: remove ethernet aliases from dtsi

Thor Thayer (2):
      ARM: dts: socfpga: Fix SDRAM node address for Arria10
      arm64: dts: stratix10: Correct System Manager register size

 arch/arm/boot/dts/socfpga.dtsi                         | 2 --
 arch/arm/boot/dts/socfpga_arria10.dtsi                 | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts        | 4 ++++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 3 +++
 5 files changed, 9 insertions(+), 4 deletions(-)
