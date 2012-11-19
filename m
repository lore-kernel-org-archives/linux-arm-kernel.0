From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 11:11:40 +0100
Subject: [GIT PULL] Marvell XOR driver DT changes
Message-ID: <1353319903-30855-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here is the DT/board changes related to the Marvell XOR driver.

Compared to v1:

 * Addition of the Kirkwood and Dove integration, provided
   respectively by Andrew Lunn and Sebastian Hesselbarth.

This must be applied on top of the Marvell XOR driver cleanup and DT
binding patch series, which itself applies on top of the clk work from
Andrew Lunn.

Thanks!

The following changes since commit 7a008db916df99af0cd1d765badcb3e4261b4021:

  dma: mv_xor: Add a device_control function (2012-11-19 10:53:30 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-xor-board-dt-changes-3.8

for you to fetch changes up to 18731aa5e333017fae0b32f85156711300571328:

  arm: dove: Convert Dove to DT XOR DMA engine (2012-11-19 10:53:32 +0100)

----------------------------------------------------------------
Marvell XOR driver DT/board changes for 3.8

----------------------------------------------------------------
Andrew Lunn (1):
      arm: kirkwood: Convert XOR instantiation to DT.

Sebastian Hesselbarth (1):
      arm: dove: Convert Dove to DT XOR DMA engine

Thomas Petazzoni (1):
      arm: mvebu: add XOR engines to Armada 370/XP .dtsi

 arch/arm/boot/dts/armada-370-xp.dtsi |   20 ++++++++++++++++
 arch/arm/boot/dts/dove.dtsi          |   42 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi      |   40 ++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/common.c          |   10 --------
 arch/arm/mach-kirkwood/board-dt.c    |   13 -----------
 5 files changed, 102 insertions(+), 23 deletions(-)
