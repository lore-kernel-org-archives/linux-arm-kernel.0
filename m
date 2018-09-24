From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 24 Sep 2018 10:23:46 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 2
Message-ID: <1537802626-10990-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these additional patches for v4.20.

Thanks,
Dinh


The following changes since commit 202eb5481421040e115526b75317b5ca72584806:

  ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,nano_soc} (2018-08-30 08:38:26 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.20_part2

for you to fetch changes up to 20373e0cb8f7d540ae082a8026f5ae7c27cc6cb3:

  ARM: dts: socfpga: add timer resets for SoCFPGA platform (2018-09-17 10:11:28 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.20, part 2
- Fix I2C bus unit-address warning with new DTC checks
- Add reset properties for timers

----------------------------------------------------------------
Dinh Nguyen (2):
      ARM: dts: socfpga: Fix I2C bus unit-address error
      ARM: dts: socfpga: add timer resets for SoCFPGA platform

 arch/arm/boot/dts/socfpga.dtsi                      | 8 ++++++++
 arch/arm/boot/dts/socfpga_arria10.dtsi              | 8 ++++++++
 arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts | 2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)
