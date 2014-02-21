From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:39 +0900
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Defconfig Updates for
 v3.15
Message-ID: <cover.1392962286.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider this third round of Renesas ARM based SoC defconfig
updates for v3.15.

This pull request is based on the previous round of
such requests, tagged as renesas-defconfig2-for-v3.15,
which I have already sent a pull-request for.


The following changes since commit 8f33d31ee270f2a6bcc661815a520f76565674c3:

  ARM: shmobile: genmai defconfig: Enable RSPI (2014-02-06 20:53:59 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig3-for-v3.15

for you to fetch changes up to 7573e89ba1fcbe492c52d5b1e72fcf5d23da21d1:

  ARM: shmobile: r7s72100: update defconfig for I2C usage (2014-02-18 11:36:33 +0900)

----------------------------------------------------------------
Third Round of Renesas ARM Based SoC Defconfig Updates for v3.15

* r7s72100 (RZ/A1H) based Genmai board
  - update defconfig for I2C usage

* r8a7791 (R-Car M2) based Koelsch board
  - Enable SDHI, GPIO and regulators in defconfig

* r8a7790 (R-Car H2) based Lager board
  - Enable RSPI and MTD_M25P80

* emev2 (Emma Mobile) based KZM9D board
  - Remove legacy KZM9D defconfig

* Multiplatform
  - Add defconfig for shmobile multiplatform

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: lager defconfig: Enable RSPI and MTD_M25P80

Magnus Damm (1):
      ARM: shmobile: Get rid of legacy KZM9D defconfig

Simon Horman (2):
      ARM: shmobile: Add defconfig for shmobile multiplatform
      ARM: shmobile: koelsch: Enable SDHI, GPIO and regulators in defconfig

Wolfram Sang (1):
      ARM: shmobile: r7s72100: update defconfig for I2C usage

 arch/arm/configs/genmai_defconfig   |   4 +-
 arch/arm/configs/koelsch_defconfig  |   9 +++
 arch/arm/configs/kzm9d_defconfig    |  91 -------------------------
 arch/arm/configs/lager_defconfig    |   4 ++
 arch/arm/configs/shmobile_defconfig | 129 ++++++++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 92 deletions(-)
 delete mode 100644 arch/arm/configs/kzm9d_defconfig
 create mode 100644 arch/arm/configs/shmobile_defconfig
