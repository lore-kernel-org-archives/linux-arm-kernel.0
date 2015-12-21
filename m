From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Mon, 21 Dec 2015 01:06:50 -0600
Subject: [GIT PULL] SoCFPGA DTS updates for v4.5, part 2
Message-ID: <1450681610-14651-1-git-send-email-dinh.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling these 2 patches for v4.5.

Thanks,
Dinh

The following changes since commit 34a315883f60344f2116dcd445388531d09dc066:

  ARM: socfpga: Add support for DENX MCV SoM and MCVEVK baseboard (2015-11-19 10:15:05 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.5_part_2

for you to fetch changes up to 91f69147d681e47e2aa2ff7dbf4c5468befa8a1b:

  ARM: socfpga: dts: Enable MMC support at correct place in the DT (2015-12-21 00:44:21 -0600)

----------------------------------------------------------------
SoCFPGA DTS update for v4.5, part 2
- clean up mcvevk dts file, replace space with tab
- Disable SDMMC node in base socfpga.dtsi file

----------------------------------------------------------------
Marek Vasut (2):
      ARM: socfpga: Repair incorrectly applied MCV patch
      ARM: socfpga: dts: Enable MMC support at correct place in the DT

 arch/arm/boot/dts/socfpga.dtsi                    |  1 +
 arch/arm/boot/dts/socfpga_arria5_socdk.dts        |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi       | 19 ++---
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts     | 90 +++++++++++------------
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts      |  1 +
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts     |  1 +
 7 files changed, 60 insertions(+), 54 deletions(-)
