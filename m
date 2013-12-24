From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:03:22 +0900
Subject: [GIT PULL 0/7] Second Round of Renesas ARM Based SoC Defconfig
 Updates for v3.14
Message-ID: <cover.1387854925.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC defconfig
updates for v3.14.

It is based on the first round of such updates,
tagged as renesas-defconfig-for-v3.14, which you have already pulled.


The following changes since commit 577092b3d11530acd8467074f6ea7e2dd36b5028:

  ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig (2013-11-24 15:13:43 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.14

for you to fetch changes up to 559cec66f1a2620bc85bb79191512a569a404cb8:

  ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in defconfig (2013-12-19 18:06:13 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Defconfig Updates for v3.14

* r7s72100 SoC (RZ/A1H) based Genmai Board
  - Fixup I2C device on defconfig
  - Add gpio regulator support on defconfig

* r8a7791 (R-Car M2) based Koelsch board
  - Do not disable CONFIG_{INOTIFY_USER,UNIX} in defconfig
  - Enable CONFIG_PACKET in defconfig
  - Enable Ether in defconfig

* r8a7740 (R-Mobile A1) based Armadillo board
  - Enable backlight control in defconfig

* r8a7740 (R-Mobile A1) based Armadillo board
  - Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY

----------------------------------------------------------------
Kuninori Morimoto (2):
      ARM: shmobile: lager: add gpio regulator support on defconfig
      ARM: shmobile: lager: fixup I2C device on defconfig

Laurent Pinchart (2):
      ARM: shmobile: genmai: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
      ARM: shmobile: armadillo800eva: Enable backlight control in defconfig

Sergei Shtylyov (1):
      ARM: shmobile: Koelsch: enable Ether in defconfig

Simon Horman (2):
      ARM: shmobile: koelsch: Enable CONFIG_PACKET in defconfig
      ARM: shmobile: koelsch: Do not disable CONFIG_{INOTIFY_USER,UNIX} in defconfig

 arch/arm/configs/armadillo800eva_defconfig |  3 +++
 arch/arm/configs/genmai_defconfig          |  2 +-
 arch/arm/configs/koelsch_defconfig         | 25 ++++++++++++++++++++++++-
 arch/arm/configs/lager_defconfig           |  3 ++-
 4 files changed, 30 insertions(+), 3 deletions(-)
