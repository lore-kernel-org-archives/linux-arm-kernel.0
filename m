From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  5 Apr 2013 11:56:22 +0900
Subject: [GIT PULL] Renesas ARM based SoC bockw defconfig updates for v3.10
Message-ID: <1365130583-11257-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 00ae962f8051bb143fa1c43c6a9c8274c3a9c593:

  ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection (2013-04-03 10:50:44 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas tags/renesas-defconfig-bockw-for-v3.10

for you to fetch changes up to e2f77f6ff54865870870aaff0c07e2c35c4e0cfa:

  ARM: shmobile: bockw: enable SMSC ethernet on defconfig (2013-04-04 15:51:12 +0900)

----------------------------------------------------------------
Renesas ARM based SoC bockw defconfig updates for v3.10

An update to the defconfig for the bockw board to enable SMSC ethernet.

This is based on:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas renesas-boards3-for-v3.10

The reason for using that base is that the bockw defconfig was added
in the boards branch instead of the defconfig branch, which was not ideal.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ARM: shmobile: bockw: enable SMSC ethernet on defconfig

 arch/arm/configs/bockw_defconfig |   34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)
