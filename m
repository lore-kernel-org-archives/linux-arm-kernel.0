From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 19 Nov 2012 18:38:24 +0100
Subject: [GIT PULL] at91: tiny cleanup for 3.8
Message-ID: <50AA6E90.5080006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A very little cleanup single patch for AT91.

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-next-cleanup

for you to fetch changes up to f7c9f47239e9bc2fdf30f51cf46249aeb79980d3:

  ARM: at91/atmel-mci: remove unused setup_dma_addr() macro (2012-11-16 11:52:36 +0100)

----------------------------------------------------------------
Removing unneeded macro.

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: at91/atmel-mci: remove unused setup_dma_addr() macro

 arch/arm/mach-at91/include/mach/atmel-mci.h | 7 -------
 1 file changed, 7 deletions(-)

Thanks, bye,
-- 
Nicolas Ferre
