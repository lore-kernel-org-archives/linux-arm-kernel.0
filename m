From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jan 2018 13:57:16 +0800
Subject: [GIT PULL 1/5] i.MX drivers updates for 4.16
Message-ID: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.16

for you to fetch changes up to cfabb7921ccbede2968e5049d433ba3d0e0950af:

  soc: imx: gpc: Add i.MX6SX PCI power domain (2017-12-26 16:26:46 +0800)

----------------------------------------------------------------
i.MX drivers update for 4.16:
 - Update i.MX GPC driver to support PCI power domain of i.MX6SX SoC.

----------------------------------------------------------------
Fabio Estevam (1):
      soc: imx: gpc: Add i.MX6SX PCI power domain

 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt |  3 +++
 drivers/soc/imx/gpc.c                                   | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)
