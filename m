From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Mar 2015 21:59:24 +0100
Subject: [GIT PULL] pxa dt for v4.1
Message-ID: <87egoo8xqr.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider these device-tree changes for pxa for v4.1 cycle.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.1

for you to fetch changes up to e3cacd113d5e3e362ee671fa42fc013efd5c2937:

  ARM: dts: pxa: add pxa-timer to pxa27x and pxa3xx (2015-02-23 19:30:04 +0100)

----------------------------------------------------------------
This device-tree pxa update brings :
 - clocks descriptions (pxa27x, pxa3xx)
 - timer descriptions (pxa27x, pxa3xx)
 - IPs which are embedded on the SoC
   - keypad
   - udc (USB client)
   - power I2C

These are amongst the building blocks for future pxa device-tree board
description.

----------------------------------------------------------------
Robert Jarzmik (5):
      ARM: dts: pxa: add pwri2c to pxa device-tree
      ARM: dts: pxa: add clocks
      ARM: dts: pxa: add pxa27x-udc to pxa27x
      ARM: dts: pxa: add pxa27x-keypad to pxa27x
      ARM: dts: pxa: add pxa-timer to pxa27x and pxa3xx

 arch/arm/boot/dts/pxa27x.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/pxa2xx.dtsi |  7 ++++++-
 arch/arm/boot/dts/pxa3xx.dtsi | 29 ++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 5 deletions(-)

-- 
Robert
