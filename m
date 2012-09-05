From: horms@verge.net.au (Simon Horman)
Date: Wed,  5 Sep 2012 17:20:39 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC: Marzen and r8a7779 for 3.7
Message-ID: <1346833244-30432-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following enhancements to the Marzen board
and r8a7779 SoC by Phil Edworthy, Morimoto-san and myself for 3.7.

This pull-request differs from v2 in that USB-related changes
have been omitted and the pull-request is no longer based on usb-next.

----------------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git marzen

for you to fetch changes up to 978792e04b58985eda62aa8cc97c6d46433103f2:

  ARM: shmobile: marzen: enable thermal sensor (2012-09-05 10:22:48 +0900)

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: marzen: fixup regulator id for smsc911x
      ARM: shmobile: marzen: enable thermal sensor

Phil Edworthy (2):
      r8a7779: add SDHI clock support
      marzen: add SDHI0 support

Simon Horman (1):
      ARM: mach-shmobile: marzen: defconfig update

 arch/arm/configs/marzen_defconfig      |   19 +++++----
 arch/arm/mach-shmobile/board-marzen.c  |   68 +++++++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7779.c |   11 +++++-
 3 files changed, 89 insertions(+), 9 deletions(-)
