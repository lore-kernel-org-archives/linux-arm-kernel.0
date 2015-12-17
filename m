From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Dec 2015 14:24:46 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.5
Message-ID: <cover.1450315426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.5.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.5

for you to fetch changes up to 3bf834e17c8736537a08abfa509ae3a8c8446b08:

  ARM: multi_v7_defconfig: Enable frame buffer console for armadillo800eva (2015-12-14 14:13:18 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.5

* multi_v7_defconfig and shmobile_defconfig:
  - Enable frame buffer console for armadillo800eva
  - Enable missing Renesas ARM support based on DTSes
  - Drop useless CONFIG_USB_RCAR_PHY=y
* shmobile_defconfig only:
  - Enable CONFIG_PRINTK_TIME

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
      ARM: shmobile: defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
      ARM: shmobile: defconfig: Enable missing support based on DTSes
      ARM: shmobile: defconfig: Enable frame buffer console for armadillo800eva
      ARM: multi_v7_defconfig: Drop useless CONFIG_USB_RCAR_PHY=y
      ARM: multi_v7_defconfig: Enable missing Renesas ARM support based on DTSes
      ARM: multi_v7_defconfig: Enable frame buffer console for armadillo800eva

 arch/arm/configs/multi_v7_defconfig |  9 ++++++++-
 arch/arm/configs/shmobile_defconfig | 12 ++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)
