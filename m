From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 13 May 2015 23:45:01 +0200
Subject: [GIT PULL] pxa-dt for v4.2
Message-ID: <87y4ksjgo2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.2 device-tree. It is the same than the
former 4.1 one.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-dt-4.2

for you to fetch changes up to 8dd3075c489ba19a8f2795199352334e52f34bed:

  ARM: dts: pxa: add pxa-timer to pxa27x and pxa3xx (2015-05-12 23:14:26 +0200)

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

Cheers.

-- 
Robert
