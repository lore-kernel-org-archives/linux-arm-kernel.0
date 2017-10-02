From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon,  2 Oct 2017 16:19:23 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.15
Message-ID: <1506979163-6296-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these SoCFPGA Stratix10 DTS updates for v4.15.

Thanks,
Dinh

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.15_part1

for you to fetch changes up to 788251fa08118efa934ba2f54989997e7a5be679:

  arm64: dts: stratix10: add reset property for various peripherals (2017-09-21 09:16:50 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.15
- Stratix10 platform updates
  - Fix up gic register entry
  - Enable ethernet/SDMMC
  - Update reset manager properties

----------------------------------------------------------------
Dinh Nguyen (5):
      arm64: dts: stratix10: fix up the gic register for the Stratix10 platform
      arm64: dts: stratix10: add ethernet/sdmmc support to the S10 devkit
      arm64: dts: stratix10: include the reset manager bindings
      arm64: dts: stratix10: add the 'altr,modrst-off' property
      arm64: dts: stratix10: add reset property for various peripherals

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  | 35 ++++++++++++++++---
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    | 40 +++++++++++++++++++++-
 2 files changed, 70 insertions(+), 5 deletions(-)
