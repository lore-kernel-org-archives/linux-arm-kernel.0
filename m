From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 18:20:33 -0400
Subject: [GIT PULL] ARM: mvebu: Fixes for v3.18
Message-ID: <20141101222033.GA3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a couple of fixes I've gathered so far for mvebu, nothing
exciting as these are quite old and were in -next for several weeks.

Please pull.

thx,

Jason.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.18

for you to fetch changes up to 9ece8839b1277fb9128ff6833411614ab6c88d68:

  ARM: orion: Fix for certain sequence of request_irq can cause irq storm (2014-11-01 22:07:45 +0000)

----------------------------------------------------------------
mvebu fixes for v3.18

 - Armada XP
    - Generalize i2c quirk

 - orion
    - Fix irq storm caused by specific sequence of request_irq

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: mvebu: armada xp: Generalize use of i2c quirk

Evgeniy Dushistov (1):
      ARM: orion: Fix for certain sequence of request_irq can cause irq storm

 arch/arm/mach-mvebu/board-v7.c |  2 +-
 arch/arm/plat-orion/gpio.c     | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)
