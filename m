From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 15:26:15 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: AG5EVM for 3.7
Message-ID: <1346394376-11951-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following enhancement to the AG5EVM board
by Wei Yongjun for inclusion in 3.7.

----------------------------------------------------------------
The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git ag5evm

for you to fetch changes up to aa9c1ba4412d2f9348b6e700aa4831569a25a7ca:

  ARM: mach-shmobile: remove duplicated include from board-ag5evm.c (2012-08-31 15:02:02 +0900)

----------------------------------------------------------------
Wei Yongjun (1):
      ARM: mach-shmobile: remove duplicated include from board-ag5evm.c

 arch/arm/mach-shmobile/board-ag5evm.c | 1 -
 1 file changed, 1 deletion(-)
