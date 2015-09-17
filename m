From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.4
Message-ID: <cover.1442479800.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.4.

This is a minor cleanup of defconfigs after reshuffling to
remove legacy board code.


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.4

for you to fetch changes up to 0a8b0695f4c490c349ee12956d6946576c44a419:

  ARM: multi_v7_defconfig: Remove Marzen (2015-09-14 10:12:59 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.4

* Remove now non-existent MACH_MARZEN from defconfigs

----------------------------------------------------------------
Magnus Damm (1):
      ARM: shmobile: Remove Marzen from shmobile_defconfig

Simon Horman (1):
      ARM: multi_v7_defconfig: Remove Marzen

 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/shmobile_defconfig | 1 -
 2 files changed, 2 deletions(-)
