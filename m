From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 25 Jun 2018 08:42:20 -0500
Subject: [GIT PULL] SoCFPGA DTS fixes for v4.18
Message-ID: <1529934140-27012-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA Stratix10 DTS fixes for v4.18.

Thanks,
Dinh

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_for_next_v4.18_fixes

for you to fetch changes up to ea38969d539d59e51e0b4bce4c5c6efcbffb0ade:

  ARM: dts: Fix SPI node for Arria10 (2018-06-25 08:28:55 -0500)

----------------------------------------------------------------
ARM: dts: socfpga: fix NAND support
- NAND should be using nand_x_clk, not nand_clk
- fix NAND node compatible for Cyclone5 and Arria10
- fix SPI node properties(unused bus-num, and use num-cs)

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: dts: socfpga: Fix NAND controller node compatible for Arria10

Marek Vasut (2):
      ARM: dts: socfpga: Fix NAND controller clock supply
      ARM: dts: socfpga: Fix NAND controller node compatible

Thor Thayer (2):
      arm64: dts: stratix10: Fix SPI nodes for Stratix10
      ARM: dts: Fix SPI node for Arria10

 arch/arm/boot/dts/socfpga.dtsi                    | 4 ++--
 arch/arm/boot/dts/socfpga_arria10.dtsi            | 5 ++---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 6 ++----
 3 files changed, 6 insertions(+), 9 deletions(-)
