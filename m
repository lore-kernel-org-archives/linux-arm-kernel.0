From: stigge@antcom.de (Roland Stigge)
Date: Tue, 09 Sep 2014 16:52:03 +0200
Subject: [GIT PULL] ARM: LPC32xx: Platform support
Message-ID: <540F1413.1020902@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ce7598c9a453e0acd0e07be7be3f5eb39608ebd:

  Linux 3.17-rc4 (2014-09-07 16:09:43 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6 lpc32xx/core

for you to fetch changes up to 767f61f47fb0e91f575ddd428b5fc018b3b88eda:

  ARM: LPC32xx: Fix reset function (2014-09-09 15:13:14 +0200)

----------------------------------------------------------------
Roland Stigge (2):
      ARM: LPC32xx: Configure DMA signals
      ARM: LPC32xx: Fix reset function

 arch/arm/mach-lpc32xx/common.c  | 29 ++++++-----------------------
 arch/arm/mach-lpc32xx/phy3250.c | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 23 deletions(-)
