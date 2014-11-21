From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 20 Nov 2014 23:18:33 -0600
Subject: [GIT PULL] SOCFPGA DTS updates for v3.19, v2
Message-ID: <1416547113-14106-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these 4 patches for v3.19. This is an updated
pull request that is based on v3.18-rc1.

Thanks,
Dinh

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_dts_updates_for_v3.19

for you to fetch changes up to 475dc86d08de4af61b6e8524bbcdbf8d675cb4fa:

  arm: dts: socfpga: Add a base DTSI for Altera's Arria10 SOC (2014-11-20 23:08:42 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v3.19

- Add DTS support for a new chip in the SOCFPGA family, the Arria 10.
- Enable watchdog node.
- Add SPI nodes.
- Add the OCRAM node.

----------------------------------------------------------------
Dinh Nguyen (3):
      arm: dts: socfpga: Add OCRAM node
      arm: dts: socfpga: enable watchdog for socfpga platform
      arm: dts: socfpga: Add a base DTSI for Altera's Arria10 SOC

Thor Thayer (1):
      arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.

 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/socfpga.dtsi              |  27 ++
 arch/arm/boot/dts/socfpga_arria10.dtsi      | 374 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dts |  48 ++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi     |   4 +
 5 files changed, 454 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10.dtsi
 create mode 100755 arch/arm/boot/dts/socfpga_arria10_socdk.dts
