From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 16:09:12 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.11 (round 2)
Message-ID: <20130520200912.GL31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 366c0b76416ed15feb90ba4ef0bd8f03d62d1091:

  ARM: mvebu: Add support for USB storage class in mvebu_defconfig (2013-05-13 20:06:06 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/defconfig-3.11-2

for you to fetch changes up to 921b1ab0af2c5e0718e0e0ef334a91aa9c4507d4:

  arm: kirkwood: update defconfig with PCIe driver and board updates (2013-05-20 19:29:31 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.11 (round 2)

 - mvebu
    - add PCI and USB

 - kirkwood
    - add DT sheevaplug, usb3 and pcie

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Enable USB 3.0 in kirkwood_defconfig

Jason Cooper (1):
      ARM: kirkwood: enable Sheevaplug DT in defconfig

Thomas Petazzoni (2):
      arm: mvebu: update defconfig with PCI and USB support
      arm: kirkwood: update defconfig with PCIe driver and board updates

 arch/arm/configs/kirkwood_defconfig | 7 ++++---
 arch/arm/configs/mvebu_defconfig    | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)
