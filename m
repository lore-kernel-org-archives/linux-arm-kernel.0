From: horms@verge.net.au (Simon Horman)
Date: Thu,  6 Sep 2012 11:04:31 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: Boards for 3.7
Message-ID: <1346897074-6276-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following board enhancement from
Phil Edworthy and Morimoto-san for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git boards

for you to fetch changes up to eb8ca943bae2b84c3fc14dfd7a908cb334465fef:

  ARM: shmobile: marzen: enable thermal sensor (2012-09-06 10:24:17 +0900)

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: marzen: fixup regulator id for smsc911x
      ARM: shmobile: marzen: enable thermal sensor

Phil Edworthy (1):
      ARM: shmobile: marzen: add SDHI0 support

 arch/arm/configs/marzen_defconfig     |    2 +
 arch/arm/mach-shmobile/board-marzen.c |   68 ++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)
