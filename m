From: stigge@antcom.de (Roland Stigge)
Date: Wed, 10 Sep 2014 15:56:21 +0200
Subject: [GIT PULL] ARM: LPC32xx: Platform specific core updates
Message-ID: <54105885.9020303@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.antcom.de/linux-2.6 lpc32xx/core

for you to fetch changes up to 0816e792911ad8fb999862114e9a2ba805aa9753:

  ARM: LPC32xx: Fix reset function (2014-09-10 15:40:33 +0200)

----------------------------------------------------------------
Roland Stigge (2):
      ARM: LPC32xx: Configure DMA signals
      ARM: LPC32xx: Fix reset function

 arch/arm/mach-lpc32xx/common.c  | 29 ++++++-----------------------
 arch/arm/mach-lpc32xx/phy3250.c | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 23 deletions(-)
