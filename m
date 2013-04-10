From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Apr 2013 13:12:54 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.9 (round 3)
Message-ID: <20130410171254.GD28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 879d68a445dd7073a8c022fcdd21dc27eca7f192:

  arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port. (2013-03-28 17:29:23 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.9_round3

for you to fetch changes up to 600468d0686096ddc1000c8a2e69475931084414:

  arm: mvebu: Fix the irq map function in SMP mode (2013-04-10 16:59:14 +0000)

----------------------------------------------------------------
mvebu fixes for v3.9 round 3

 - Kirkwood
    - a couple of small fixes for the Iomega ix2-200 board (ether and led)
 - mvebu
    - allow GPIO button to work on Mirabox when running SMP

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm: mvebu: Fix the irq map function in SMP mode

Nigel Roberts (2):
      ARM: Kirkwood: Fix typo in the definition of ix2-200 rebuild LED
      Fix GE0/GE1 init on ix2-200 as GE0 has no PHY

 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 14 +++++++-------
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |  7 ++++++-
 arch/arm/mach-mvebu/irq-armada-370-xp.c       | 16 +++++-----------
 3 files changed, 18 insertions(+), 19 deletions(-)
