From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue, 23 Jan 2018 09:54:34 -0600
Subject: [GIT PULL] SoCFPGA DTS updates for v4.16
Message-ID: <1516722874-15698-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

I apologize for the late request! I figure these changes are mostly trivial
DTS updates, perhaps you can consider pulling them in for v4.16? If not, they can
wait.

Thanks,
Dinh


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.16

for you to fetch changes up to 889d1509042096f6ccd082655997aeff8457fe1c:

  arm64: dts: stratix10: fix SPI settings (2018-01-23 09:37:29 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.16
- Stratix10 platform updates
  - Fix SPI interrupt numbers
  - Enable USB
- Disable over-current for Arria10 devkit

----------------------------------------------------------------
Dinh Nguyen (3):
      ARM: dts: socfpga: disable over-current for Arria10 USB devkit
      arm64: dts: stratix10: enable USB on the devkit
      arm64: dts: stratix10: add USB ECC reset bit

Thor Thayer (1):
      arm64: dts: stratix10: fix SPI settings

Tim Sander (1):
      ARM: dts: socfpga: add i2c reset signals

 arch/arm/boot/dts/socfpga.dtsi                         |  4 ++++
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi           |  1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 16 ++++++++++------
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts |  4 ++++
 4 files changed, 19 insertions(+), 6 deletions(-)
