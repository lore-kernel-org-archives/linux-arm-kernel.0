From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 25 Oct 2011 13:21:45 +0200
Subject: [GIT PULL] at91 device tree basics
Message-ID: <4EA69BC9.8040402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

The following changes since commit c3b92c8787367a8bb53d57d9789b558f1295cc96:

  Linux 3.1 (2011-10-24 09:10:05 +0200)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd/at91-dt

They cover the basic device tree work done during the last moths around both 
at91sam9g45 and at91sam9g20 based board. They have been review by Grant and
Rob. More device tree related stuff is comming ;-)


Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: add at91sam9g20 and Calao USB A9G20 DT support

Nicolas Ferre (1):
      ARM: at91: dt: at91sam9g45 family and board device tree files

 arch/arm/boot/dts/at91sam9g20.dtsi     |  119 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |  106 +++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   35 +++++++++
 arch/arm/boot/dts/usb_a9g20.dts        |   30 ++++++++
 arch/arm/mach-at91/Kconfig             |   11 +++
 arch/arm/mach-at91/Makefile            |    3 +
 arch/arm/mach-at91/Makefile.boot       |    2 +
 arch/arm/mach-at91/at91sam9260.c       |    8 ++
 arch/arm/mach-at91/at91sam9g45.c       |    6 ++
 arch/arm/mach-at91/board-dt.c          |  123 ++++++++++++++++++++++++++++++++
 10 files changed, 443 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g20.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9g45.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9m10g45ek.dts
 create mode 100644 arch/arm/boot/dts/usb_a9g20.dts
 create mode 100644 arch/arm/mach-at91/board-dt.c

Thanks, best regards,
-- 
Nicolas Ferre
