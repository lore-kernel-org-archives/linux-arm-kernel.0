From: nsekhar@ti.com (Nori, Sekhar)
Date: Sat, 17 Sep 2011 17:13:36 +0530
Subject: [GIT PULL] davinci fixes for v3.2 merge window
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302575A0DD6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following two fixes for the v3.2
merge window. They are not applicable to stable
tree and hence the stable tag has not been added.

Thanks,
Sekhar

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
  Linus Torvalds (1):
        Linux 3.1-rc6

are available in the git repository at:

  git://gitorious.org/linux-davinci/linux-davinci.git v3.2/fixes

Ido Yariv (1):
      ARM: davinci: Explicitly set channel controllers' default queues

Thomas Meyer (1):
      ARM: davinci: edma: use kzalloc()

 arch/arm/mach-davinci/devices-da8xx.c     |    3 +++
 arch/arm/mach-davinci/devices-tnetv107x.c |    1 +
 arch/arm/mach-davinci/dm355.c             |    1 +
 arch/arm/mach-davinci/dm644x.c            |    1 +
 arch/arm/mach-davinci/dm646x.c            |    1 +
 arch/arm/mach-davinci/dma.c               |    5 +----
 6 files changed, 8 insertions(+), 4 deletions(-)
