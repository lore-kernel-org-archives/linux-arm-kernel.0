From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  5 Apr 2013 12:04:28 +0900
Subject: [GIT PULL] Renesas ARM-based SoC bockw board updates for v3.10
Message-ID: <1365131070-13142-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 5e3780ba6dded2636c939549e3bea16d736859fb:

  Merge branch 'soc-r8a7778' into boards-bockw-base (2013-04-05 11:32:38 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas tags/renesas-boards-bockw-for-v3.10

for you to fetch changes up to 446ee9b2d813a9378e304008fc433ce543ca68a1:

  ARM: shmobile: bockw: enable network settings on bootargs (2013-04-05 11:32:53 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC bockw board updates for v3.10

Add SMSC ethernet support to the bockw board.

This pull request is based on a merge of:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-r8a7778-for-v3.10
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-boards3-for-v3.10

The reason for merging with renesas-soc-r8a7778-for-v3.10 is
to provide pre-requisite SoC code to configure IRQ pins for the
SMSC ethernet.

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: bockw: add SMSC ethernet support
      ARM: shmobile: bockw: enable network settings on bootargs

 arch/arm/boot/dts/r8a7778-bockw.dts  |    2 +-
 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/board-bockw.c |   38 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)
