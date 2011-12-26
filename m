From: yanok@emcraft.com (Ilya Yanok)
Date: Tue, 27 Dec 2011 00:08:30 +0100
Subject: [PATCH 0/2] Support for TeeJet Mt.Ventoux
Message-ID: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split into two parts:
 1. Device tree only to be used with board-generic (only serial works)
 2. Full board support via custom machine file for board-testing

Ilya Yanok (2):
  mt_ventoux: very basic support for TeeJet Mt.Ventoux board
  mt_ventoux: support for TeeJet Mt.Ventoux board

 arch/arm/boot/dts/am3517_mt_ventoux.dts       |   27 +
 arch/arm/mach-omap2/Kconfig                   |    6 +
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-am3517_mt_ventoux.c |  708 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h  |    1 +
 5 files changed, 743 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517_mt_ventoux.dts
 create mode 100644 arch/arm/mach-omap2/board-am3517_mt_ventoux.c

-- 
1.7.6.4
