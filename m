From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 28 Nov 2018 09:44:03 -0600
Subject: [GIT PULL 2/2] ARM: dts: socfpga: updates for v5.0
In-Reply-To: <20181128154403.12872-1-dinguyen@kernel.org>
References: <20181128154403.12872-1-dinguyen@kernel.org>
Message-ID: <20181128154403.12872-2-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v5.0.

Thanks,
Dinh

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_updates_for_v5.0

for you to fetch changes up to 8bb4f3f55961954154967d4747686ababb67df0d:

  arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding (2018-11-28 09:24:52 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v5.0
- Use SPDX license identifier for all SoCFPGA DTS files.
- Remove dma-mask property as it has been deprecated.
- Use tabs in DTS files.
- Use the specific "altr,stratix10-rst-mgr" property for the Stratix10
  reset manager.

----------------------------------------------------------------
Dinh Nguyen (2):
      arm: dts: socfpga: remove dma-mask property
      arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding

Simon Goldschmidt (2):
      arm: dts: socfpga*.dts*: use SPDX-License-Identifier
      ARM: dts: socfpga: use tabs for indentation

 arch/arm/boot/dts/socfpga.dtsi                     | 19 ++-------
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 14 +------
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       | 14 +------
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts   | 13 +-----
 arch/arm/boot/dts/socfpga_arria10_socdk_qspi.dts   | 13 +-----
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  | 14 +------
 arch/arm/boot/dts/socfpga_arria5.dtsi              | 15 +------
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         | 16 +-------
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            | 16 +-------
 .../arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts | 13 +-----
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi        | 14 +------
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      | 14 +------
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       | 16 +-------
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      | 16 +-------
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    | 16 +-------
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts       | 20 ++--------
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 46 +---------------------
 arch/arm/boot/dts/socfpga_vt.dts                   | 16 +-------
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 +-
 19 files changed, 32 insertions(+), 276 deletions(-)
