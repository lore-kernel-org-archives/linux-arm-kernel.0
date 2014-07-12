From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 12 Jul 2014 15:53:23 +0200
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Defconfig Updates for
 v3.17
Message-ID: <cover.1405173007.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC defconfig updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig2-for-v3.17,
which I have already sent a pull-request for.


The following changes since commit c61010050d3baa3e1a3964bec7e62437d21107c6:

  ARM: shmobile: Enable genmai board in multiplatform defconfig (2014-06-25 16:46:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-defconfig3-for-v3.17

for you to fetch changes up to 8cbf869a0a278c4d39e50daa4f4101b394a72a93:

  ARM: shmobile: Enable R-Car Gen 2 PCIe in shmobile_defconfig (2014-07-09 10:44:12 +0200)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Defconfig Updates for v3.17

* Enable R-Car Gen 2 PCIe in shmobile_defconfig

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: Enable R-Car Gen 2 PCIe in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)
