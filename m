From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Aug 2012 14:38:58 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fix for v3.6
Message-ID: <1346305139-24337-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following boot-failure fix for the Marzen board from
Morimoto-san for inclusion in 3.6.

----------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes

for you to fetch changes up to 497dcf6fc355f0734faf851662b6957386715d24:

  ARM: shmobile: marzen: fixup smsc911x id for regulator (2012-08-30 14:10:08 +0900)

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: marzen: fixup smsc911x id for regulator

 arch/arm/mach-shmobile/board-marzen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
