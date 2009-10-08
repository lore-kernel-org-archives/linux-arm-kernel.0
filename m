From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:16 +0200
Subject: Some mxc patches for -rc
Message-ID: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some more mxc related patches for -rc.

Sascha

The following changes since commit 374576a8b6f865022c0fd1ca62396889b23d66dd:
  Linus Torvalds (1):
        Linux 2.6.32-rc3

are available in the git repository at:

  none ..BRANCH.NOT.VERIFIED..

Sascha Hauer (6):
      i.MX27 clock: rename spi clocks to match device
      mx25 devices: Add missing include
      mx25pdk: remove nand support as it is not present in current tree
      mx25: Add missing copyright / license header
      pcm038: Add SPI/MC13783 support
      pcm970 mmc: Fix ro switch

 arch/arm/mach-mx2/clock_imx27.c      |    6 +-
 arch/arm/mach-mx2/pcm038.c           |   92 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-mx2/pcm970-baseboard.c |    2 +-
 arch/arm/mach-mx25/devices.c         |   19 +++++++
 arch/arm/mach-mx25/mx25pdk.c         |   25 +++++++---
 5 files changed, 131 insertions(+), 13 deletions(-)
