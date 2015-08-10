From: dinh.linux@gmail.com (dinh.linux at gmail.com)
Date: Sun,  9 Aug 2015 22:15:56 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.3, part 2
Message-ID: <1439176556-30367-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

This is a 2nd pull-request for v4.3. Please consider pulling in this patches.

Thanks,
Dinh


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.3_part_2

for you to fetch changes up to 6855e5b7090330add9521d8947017875d5f4f88e:

  ARM: socfpga: dts: Add resets for EMACs on Arria10 (2015-08-09 21:58:58 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.3, take 2
- Add DTS property "altr,modrst-offset" for reset driver to
  use
- Add updated reset defines for the reset driver
- Add reset property for EMACs on Arria10

----------------------------------------------------------------
Dinh Nguyen (3):
      dt-bindings: Add reset manager offsets for Arria10
      ARM: socfpga: dts: add "altr,modrst-offset" property
      ARM: socfpga: dts: Add resets for EMACs on Arria10

 .../devicetree/bindings/reset/socfpga-reset.txt    |   2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   6 ++
 include/dt-bindings/reset/altr,rst-mgr-a10.h       | 110 +++++++++++++++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10.h
