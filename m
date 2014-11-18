From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 17 Nov 2014 22:03:35 -0600
Subject: [GIT PULL 2/2] SOCFPGA DTS updates for v3.19
In-Reply-To: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
References: <1416283415-6563-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1416283415-6563-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these 4 patches for v3.19.

Thanks,
Dinh

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_dts_updates_for_v3.19

for you to fetch changes up to b313f03020db4ccb2e8254b5aa14286d7dd5172d:

  arm: dts: socfpga: Add a base DTSI for Altera's Arria10 SOC (2014-11-17 15:09:46 -0600)

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
