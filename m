From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 27 Jan 2012 17:26:17 +0000
Subject: [GIT PULL] DaVinci fixes for v3.3-rc
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317A70FB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

Can you please pull these DaVinci fixes for the next v3.3-rc?
Both the patches have not been stable tagged. The fix by me
is a v3.3 regression. The fix by Bas van den Berg is not critical
enough to get into stable kernels.

Thanks,
Sekhar

The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git fixes

Bas van den Berg (1):
      ARM: davinci: DA850: remove non-existing pll1_sysclk4-7 clocks

Sekhar Nori (1):
      ARM: davinci: update mdio bus name

 arch/arm/mach-davinci/board-da850-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    |    2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |    2 +-
 arch/arm/mach-davinci/board-sffsdr.c        |    2 +-
 arch/arm/mach-davinci/da850.c               |   32 ---------------------------
 8 files changed, 7 insertions(+), 39 deletions(-)
