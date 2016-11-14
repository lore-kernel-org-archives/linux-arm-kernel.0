From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 14 Nov 2016 19:39:23 +0100
Subject: [GIT PULL] ARM: at91: dt for 4.10
Message-ID: <20161114183923.k5eki5fzzdfsx2j6@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

at91 DT changes for 4.10, I don't expect much more this cycle.

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.10-dt1

for you to fetch changes up to b662a9dd8a1a03e6e2d61e74d3e7a08400edefb7:

  ARM: dts: at91: replace gpio-key,wakeup with wakeup-source for sam9260ek (2016-11-14 17:04:24 +0100)

----------------------------------------------------------------
DT changes for 4.10:

 - Many additions for sama5d2
 - few non urgent fixes for sam9260ek, sama5d4 and sama5d2

----------------------------------------------------------------
Alexandre Belloni (4):
      ARM: dts: at91: sama5d4: use proper sckc compatible
      ARM: dts: at91: sama5d2: use correct sckc compatible
      ARM: dts: at91: sama5d2: Add secumod node
      ARM: dts: at91: sama5d2: Add securam node

Cyrille Pitchen (1):
      ARM: dts: at91: sama5d2: enable FIFOs for high-speed i2c controllers

Marek Vasut (1):
      ARM: dts: at91: sama5d4: Add new MA5D4EVK manufacturer compat

Peter Rosin (1):
      dt-bindings: usb: atmel: fix a couple of copy-paste style typos

Sudeep Holla (1):
      ARM: dts: at91: replace gpio-key,wakeup with wakeup-source for sam9260ek

Sylvain Rochet (1):
      ARM: dts: at91: fixes dbgu pinctrl, set pullup on rx, clear pullup on tx

 .../devicetree/bindings/usb/atmel-usb.txt          | 10 ++---
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  4 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |  4 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |  4 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  4 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  4 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  4 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 47 ++++++++++++----------
 arch/arm/boot/dts/sama5d3.dtsi                     |  4 +-
 arch/arm/boot/dts/sama5d4.dtsi                     | 31 +++-----------
 15 files changed, 60 insertions(+), 76 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/26c4f372/attachment.sig>
