From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:34:16 +0100
Subject: i.MX patches for -rc
Message-ID: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series contains some fixes for i.MX

Sascha

The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-rc-pu

Sascha Hauer (3):
      ARM mx3fb: check for DMA engine type
      ARM i.MX: sdma is merged, so remove #ifdef SDMA_IS_MERGED
      ARM i.MX pcm037 eet: compile fixes

 arch/arm/mach-mx3/mach-pcm037_eet.c          |    3 +--
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    8 --------
 drivers/video/mx3fb.c                        |    4 ++++
 3 files changed, 5 insertions(+), 10 deletions(-)
