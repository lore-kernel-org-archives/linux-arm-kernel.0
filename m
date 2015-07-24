From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:44:49 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.3
Message-ID: <cover.1437727455.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.3.


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.3

for you to fetch changes up to 821e79cb5686695f0adaef61587a184e953a937e:

  ARM: shmobile: Remove marzen_defconfig (2015-07-17 08:29:45 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.3

* Remove marzen_defconfig
* shmobile_defconfig and multi_v7_defconfig
  - Enable DPCM Sound Card
  - Enable r8a7793/gose platform

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: defconfig: add Renesas DPCM Sound Card
      ARM: multi_v7_defconfig: add Renesas DPCM Sound Card

Magnus Damm (1):
      ARM: shmobile: Remove marzen_defconfig

Simon Horman (2):
      ARM: shmobile: Enable gose board in multiplatform defconfig
      ARM: multi_v7_defconfig: Enable shmobile r8a7793/gose platform

 arch/arm/configs/marzen_defconfig   | 124 ------------------------------------
 arch/arm/configs/multi_v7_defconfig |   2 +
 arch/arm/configs/shmobile_defconfig |   2 +
 3 files changed, 4 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/configs/marzen_defconfig
