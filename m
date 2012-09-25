From: stigge@antcom.de (Roland Stigge)
Date: Tue, 25 Sep 2012 10:25:08 +0200
Subject: [GIT PULL] ARM: LPC32xx: DTS updates #2
Message-ID: <50616A64.8040600@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is a second round of mach-lpc32xx specific updates for 3.7, below
the dts branch. Only one patch for adjusting phy3250.dts.

Thanks,

Roland


The following changes since commit 25b3ab6c7e39e42245d98c27d25d9902baec7b65:

  ARM: LPC32xx: Extend dts for EA3250 board (2012-09-06 11:40:48 +0200)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx/dts

for you to fetch changes up to 07c7e12ca7e32e942d2c42dd67329c5fc3886b07:

  ARM: LPC32xx: LED fix in PHY3250 DTS file (2012-09-25 10:11:41 +0200)

----------------------------------------------------------------
Roland Stigge (1):
      ARM: LPC32xx: LED fix in PHY3250 DTS file

 arch/arm/boot/dts/phy3250.dts |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)
