From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:26:02 +0100
Subject: more i.MX patches for -rc
Message-ID: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 11dda987e916b743f7338ed5f9134b082d2cb541:

  Merge branch 'imx-rc-pu' into imx-for-2.6.37 (2010-11-05 09:20:29 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git imx-rc-pu

Sascha Hauer (3):
      ARM mx3_camera: check for DMA engine type
      ARM i.MX27 eukrea: Fix compilation
      ARM i.MX spi: fix compilation for i.MX21

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    6 ------
 arch/arm/plat-mxc/devices/platform-spi_imx.c |    1 +
 drivers/media/video/mx3_camera.c             |    4 ++++
 3 files changed, 5 insertions(+), 6 deletions(-)
