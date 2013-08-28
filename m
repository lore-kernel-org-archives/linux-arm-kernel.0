From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:40:14 +0900
Subject: [GIT PULL 0/2] Second round of Renesas ARM based SoC defconfig
 updates for v3.12
Message-ID: <cover.1377652426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC defconfig
updates for v3.12.

It is based on renesas-defconfig-for-v3.12 ("ARM based SoC defconfig
updates for v3.12") which you have previously pulled.

I apologise that this and other pull requests that I will send today
are rather later in the cycle than I would like. This is primarily due
to a combination of my summer vacation and wanting to let the patches
sit in next for a while.


The following changes since commit 461cd47a65f5d8513a983ebd21ef7c23d4b4730f:

  ARM: shmobile: ape6evm: Enable gpio-leds in defconfig (2013-08-06 10:14:09 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.12

for you to fetch changes up to d5ba7161270d10df4878762e085889fb8501fcf9:

  ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig (2013-08-22 10:55:03 +0900)

----------------------------------------------------------------
Second round of Renesas ARM based SoC defconfig updates for v3.12

* Select DRM_RCAR_DU in marzen and lager defconfigs

----------------------------------------------------------------
Laurent Pinchart (2):
      ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
      ARM: shmobile: lager: Select DRM_RCAR_DU in defconfig

 arch/arm/configs/lager_defconfig  | 2 ++
 arch/arm/configs/marzen_defconfig | 2 ++
 2 files changed, 4 insertions(+)
