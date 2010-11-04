From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:14:09 +0100
Subject: [PATCH] i.MX SDMA without firmware
Message-ID: <1288887251-31851-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following series allows to run the i.MX SDMA engine without
additional firmware.
@Dan: I would prefer to push this via my i.MX tree to keep the correct
order and prevent merge conflicts if this is ok with you.

Sascha

The following changes since commit c8ddb2713c624f432fa5fe3c7ecffcdda46ea0d4:

  Linux 2.6.37-rc1 (2010-11-01 07:54:12 -0400)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git sdma-pu

Sascha Hauer (2):
      dmaengine i.MX SDMA: Allow to run without firmware
      ARM i.MX SDMA: Add ROM script addresses to platform_data

 arch/arm/plat-mxc/devices/platform-imx-dma.c |   99 ++++++++++++++-
 arch/arm/plat-mxc/include/mach/sdma.h        |   46 +++++++
 drivers/dma/imx-sdma.c                       |  174 ++++++++++++--------------
 3 files changed, 218 insertions(+), 101 deletions(-)
