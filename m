From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 19 Jun 2013 22:22:31 +0900
Subject: [GIT PULL 0/4] Renesas ARM based SoC pinmux and GPIO update for v3.11
 #2
Message-ID: <1371648155-18479-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider these pinmux updates for v3.11.

This pull-request is based on renesas-pinmux-for-v3.11 which you
have already pulled.

The following changes since commit 5fcf4a3c3a5bc08bf72a50ef1332501a3c1b96bb:

  ARM: shmobile: marzen: Use RCAR_GP_PIN macro (2013-06-05 17:18:24 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux2-for-v3.11

for you to fetch changes up to cd622017eb3e0ab841502df88fb7fda3c3a58eb9:

  sh-pfc: r8a7778: tidyup MMC_D1 pin (2013-06-18 16:13:28 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC pinmux and GPIO update for v3.11

tidyup MMC_D1 pin for r8a7778 SoC
fix two pin numbers and add HSCIF pin groups to r8a7790 SoC
add pinmux data for MMCIF and SDHI interfaces for r8a73a4 SoC

----------------------------------------------------------------
Guennadi Liakhovetski (2):
      pinctrl: r8a73a4: add pinmux data for MMCIF and SDHI interfaces
      pinctrl: r8a7790: fix two pin numbers

Kuninori Morimoto (1):
      sh-pfc: r8a7778: tidyup MMC_D1 pin

Ulrich Hecht (1):
      sh-pfc: r8a7790: add HSCIF pin groups

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 198 ++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   4 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 227 +++++++++++++++++++++++++++++++----
 3 files changed, 403 insertions(+), 26 deletions(-)
