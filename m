From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 4 Sep 2014 11:11:44 -0500
Subject: [GIT PULL 1/2] SOCFPGA updates for 3.18
Message-ID: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v3.18. 5 of the 6 patches are
DTS updates and the 1 patch is updating the MAINTAINERS entry with my new
email address.

Thanks,
Dinh

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_update_for_v3.18

for you to fetch changes up to 75a41826e2c5dc1dc0fd5195fc29b031c97337af:

  arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries. (2014-09-04 10:15:52 -0500)

----------------------------------------------------------------
arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries.

----------------------------------------------------------------
Dinh Nguyen (4):
      MAINTAINERS: update entries for ARM/SOCFPGA platform
      ARM: dts: socfpga: remove extra alias in the ArriaV devkit
      ARM: dts: socfpga: Add SD card detect
      ARM: dts: socfpga: memreserve first 4KB for future system use

Jaehoon Chung (1):
      ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc

Thor Thayer (1):
      arm: dts: Add Altera SDRAM EDAC bindings & devicetree entries.

 .../devicetree/bindings/arm/altera/socfpga-sdram-edac.txt | 15 +++++++++++++++
 MAINTAINERS                                               |  7 +++++--
 arch/arm/boot/dts/socfpga.dtsi                            | 11 +++++++++++
 arch/arm/boot/dts/socfpga_arria5.dtsi                     | 11 +++++------
 arch/arm/boot/dts/socfpga_arria5_socdk.dts                |  7 -------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi                   | 13 ++++++-------
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts              |  4 ++++
 arch/arm/boot/dts/socfpga_vt.dts                          |  9 +++------
 8 files changed, 49 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
