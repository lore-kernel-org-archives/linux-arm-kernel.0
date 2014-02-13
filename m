From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:22 +0900
Subject: [GIT PULL 0/4] Second Round of Renesas ARM Based SoC Defconfig
 Updates for v3.15
Message-ID: <cover.1392276997.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this second round of Renesas ARM based SoC defconfig
updates for v3.15.

This pull-request is based on the first round of such updates,
tagged as renesas-defconfig-for-v3.15, which I have previously sent
a pull-request for.


The following changes since commit 0771ddff31186836f62a20c42e7958bd37f7b4ed:

  ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig (2014-02-04 10:26:04 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.15

for you to fetch changes up to 8f33d31ee270f2a6bcc661815a520f76565674c3:

  ARM: shmobile: genmai defconfig: Enable RSPI (2014-02-06 20:53:59 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v3.15

* r7s72100 SoC (RZ/A1H) based Genmai board
  - Enable RSPI

* r8a7790 (R-Car H2) based Koelsch board
  - Enable I2C, RSPI and MTD_M25P80

* r8a7779 (R-Car H1) based Lager board
  - Enable sound

----------------------------------------------------------------
Geert Uytterhoeven (2):
      ARM: shmobile: koelsch defconfig: Enable RSPI and MTD_M25P80
      ARM: shmobile: genmai defconfig: Enable RSPI

Kuninori Morimoto (1):
      ARM: shmobile: lager: add sound support on defconfig

Valentine Barshak (1):
      ARM: shmobile: koelsch: Enable I2C in defconfig

 arch/arm/configs/genmai_defconfig  | 2 ++
 arch/arm/configs/koelsch_defconfig | 6 ++++++
 arch/arm/configs/lager_defconfig   | 4 ++++
 3 files changed, 12 insertions(+)
