From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  6 Dec 2010 11:09:56 +0100
Subject: [PATCH for -rc] dmaengine: i.MX SDMA fixes
Message-ID: <1291630198-9690-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series contains some fixes for the i.MX SDMA driver. Please
consider them for -rc.

Sascha

The following changes since commit 771f8bc71c31c6bd103cdec283012253f352ab1c:

  Merge branch 'slab/urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6 (2010-12-05 16:45:02 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git sdma-fixes

Sascha Hauer (2):
      dmaengine i.MX SDMA: initialize on module_init
      dmaengine i.MX SDMA: protect channel0

 drivers/dma/imx-sdma.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)
