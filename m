From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri,  5 Aug 2011 17:24:51 +0100
Subject: AT91: dt: basic device tree showcase
Message-ID: <1312561493-7849-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a showcase, this is a basic device tree support for at91 SoC.
It add at91sam9g45 SoC with its Evaluation Kit board descriptions.
Only the dmaengine driver is converted at the moment so the support
is fairly simple.

Nicolas Ferre (2):
      AT91: dt: at91sam9g45 family and board device tree files
      AT91: dt: simple device tree support for at91sam9g45 family

 arch/arm/boot/dts/at91sam9g45.dtsi       |   27 ++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts   |   15 ++++++++++++
 arch/arm/mach-at91/Kconfig               |    8 ++++++
 arch/arm/mach-at91/Makefile.boot         |    2 +
 arch/arm/mach-at91/at91sam9g45_devices.c |    3 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   36 ++++++++++++++++++++++++++++++
 6 files changed, 90 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g45.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9m10g45ek.dts
