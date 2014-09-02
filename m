From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Sep 2014 10:31:52 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Defconfig Updates for
 v3.18
Message-ID: <cover.1409621323.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these third round of Renesas ARM based SoC defconfig
updates for v3.18.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig2-for-v3.18,
which I have already sent a pull-request for.


The following changes since commit 99923753e7c17a9c9d46bfe4d7fa543e426ec647:

  ARM: shmobile: bockw: Do not disable SUSPEND in defconfig (2014-08-22 10:40:31 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig3-for-v3.18

for you to fetch changes up to de46e95cdb8671e2b0728923b8113654779c3ba8:

  ARM: shmobile: Enable Armadillo 800 EVA board in multiplatform defconfig (2014-09-01 10:46:57 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Defconfig Updates for v3.18

* Enable Armadillo 800 EVA board in multiplatform defconfig

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Enable Armadillo 800 EVA board in multiplatform defconfig

 arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)
