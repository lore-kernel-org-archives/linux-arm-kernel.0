From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 20 Sep 2013 10:17:59 +0530
Subject: [GIT PULL v2] DaVinci fixes for v3.12-rc2
Message-ID: <523BD37F.2010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.12-rc2-v2

for you to fetch changes up to 016b9eb0c52ed7349ffdb42b4e51c93ad1f5d90a:

  ARM: davinci: dm365 evm: fix unused variable warning (2013-09-19 14:56:03 +0530)

----------------------------------------------------------------
DaVinci fixes for v3.12-rc2
---------------------------

This pull request includes:

1) A patch to fix build breakage with DEBUG_LL
2) A patch to quell a build-time warning.

----------------------------------------------------------------
Brian Norris (1):
      ARM: davinci: dm365 evm: fix unused variable warning

Sekhar Nori (1):
      ARM: davinci: fix build breakage with DEBUG_LL

 arch/arm/mach-davinci/board-dm365-evm.c     |    2 +-
 arch/arm/mach-davinci/include/mach/serial.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
