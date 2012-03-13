From: stigge@antcom.de (Roland Stigge)
Date: Tue, 13 Mar 2012 23:15:58 +0100
Subject: [GIT PULL] LPC32xx: USB Support
Message-ID: <4F5FC71E.30907@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

now that Greg-KH has accepted the LPC32xx OHCI patches into usb-next,
I'm providing the respective lpc32xx platform code as described below.

It's on top of v3.3-rc5 and the LPC32xx patches in arm-soc. Thanks
Arnd for helping woth this.

Thanks in advance,

Roland



The following changes since commit a7e4c6a7145ee375a688e1701ae4c975d6c6419a:

  Merge branch 'lpc32xx/drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc into lpc32xx/tmp (2012-03-13 21:15:40 +0100)

are available in the git repository at:


  git://git.antcom.de/linux-2.6.git lpc32xx/mach-lpc32xx-usb

for you to fetch changes up to 48a5dedfa78899dad50b3b4ae30f07e27e6591ab:

  ARM: LPC32xx: USB Support (2012-03-13 21:15:50 +0100)

----------------------------------------------------------------
Roland Stigge (1):
      ARM: LPC32xx: USB Support

 arch/arm/mach-lpc32xx/clock.c   |   87 ++++++++++++++++++++++++++++-----------
 arch/arm/mach-lpc32xx/common.c  |   26 ++++++++++++
 arch/arm/mach-lpc32xx/common.h  |    1 +
 arch/arm/mach-lpc32xx/phy3250.c |    1 +
 4 files changed, 91 insertions(+), 24 deletions(-)
