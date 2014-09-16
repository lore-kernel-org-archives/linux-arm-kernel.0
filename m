From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 16 Sep 2014 10:57:43 +0900
Subject: [GIT PULL] Fourth Round of Renesas ARM Based SoC Defconfig Updates
 for v3.18
Message-ID: <cover.1410832469.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these fourth round of Renesas ARM based SoC defconfig updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig3-for-v3.18,
which you have pulled.


The following changes since commit de46e95cdb8671e2b0728923b8113654779c3ba8:

  ARM: shmobile: Enable Armadillo 800 EVA board in multiplatform defconfig (2014-09-01 10:46:57 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig4-for-v3.18

for you to fetch changes up to 7d984c95723725d26f3961c1655c20256f0affdf:

  ARM: shmobile: Enable r8a7794 SoC in shmobile_defconfig (2014-09-11 09:49:40 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM Based SoC Defconfig Updates for v3.18

* Enable r8a7794 SoC in shmobile_defconfig

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: Enable r8a7794 SoC in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)
