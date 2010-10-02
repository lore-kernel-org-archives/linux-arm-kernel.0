From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Sat,  2 Oct 2010 11:49:54 +0200
Subject: [PATCHv2 0/1] Add initial support for OMAP3 IGEP module
Message-ID: <1286012995-2697-1-git-send-email-eballetbo@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello,

This is the version 2 of patch series to introduce the OMAP3
IGEP module support. Thanks for your comments.

Changes since v1:
 - add DEBUG_LL/EARLY_PRINTK entry

arch/arm/mach-omap2/Kconfig                  |    5 +
arch/arm/mach-omap2/Makefile                 |    2 +
arch/arm/mach-omap2/board-igep0030.c         |  412 ++++++++++++++++++++++++++
arch/arm/plat-omap/include/plat/uncompress.h |    1 +
4 files changed, 420 insertions(+), 0 deletions(-)

Kind regards,
  Enric
