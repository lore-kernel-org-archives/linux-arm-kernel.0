From: dinguyen@kernel.org (Dinh Nguyen)
Date: Tue,  2 Oct 2018 09:30:05 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 3
Message-ID: <1538490605-26653-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these additional patches for v4.20.

Thanks,
Dinh

The following changes since commit 20373e0cb8f7d540ae082a8026f5ae7c27cc6cb3:

  ARM: dts: socfpga: add timer resets for SoCFPGA platform (2018-09-17 10:11:28 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_updates_for_v4.20_part3

for you to fetch changes up to 725fc0551c9d124abd032273f49963d7f3cc4fa3:

  arm64: dts: stratix10: add ethernet aliases (2018-09-28 14:33:03 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.20, part 3
- Add ethernet aliases for Arria10 and Stratix10
- Correct system manager register size for Stratix10
- Correct SDRAM node address for Arria10

----------------------------------------------------------------
Dinh Nguyen (1):
      arm64: dts: stratix10: add ethernet aliases

Steffen Trumtrar (1):
      ARM: dts: socfpga: arria10: add aliases for ethernet

Thor Thayer (2):
      ARM: dts: socfpga: Fix SDRAM node address for Arria10
      arm64: dts: stratix10: Correct System Manager register size

 arch/arm/boot/dts/socfpga_arria10.dtsi            | 9 ++++++++-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 8 +++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)
