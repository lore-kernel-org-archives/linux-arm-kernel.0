From: stigge@antcom.de (Roland Stigge)
Date: Thu, 06 Sep 2012 13:56:59 +0200
Subject: [GIT PULL] ARM: LPC32xx: dts update
Message-ID: <50488F8B.4070801@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

below is the LPC32xx dts update branch for 3.7. Updates for reference boards
PHY3250 and EA3250.

Thanks,

Roland


The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4 (2012-09-01 10:39:58 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/dts

for you to fetch changes up to 25b3ab6c7e39e42245d98c27d25d9902baec7b65:

  ARM: LPC32xx: Extend dts for EA3250 board (2012-09-06 11:40:48 +0200)

----------------------------------------------------------------
Roland Stigge (2):
      ARM: LPC32xx: Adjust device tree node to new standard num-cs
      ARM: LPC32xx: Extend dts for EA3250 board

 arch/arm/boot/dts/ea3250.dts  |  109 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/phy3250.dts |    4 +-
 2 files changed, 109 insertions(+), 4 deletions(-)
