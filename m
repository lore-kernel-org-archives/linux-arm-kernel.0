From: peda@axentia.se (Peter Rosin)
Date: Fri,  1 Dec 2017 23:44:23 +0100
Subject: [PATCH 0/2] Add devicetree for Axentia Nattis
Message-ID: <20171201224425.5477-1-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'd like to add a devicetree for our Nattis to the kernel. The
Nattis is a device for showing departures for public transportation
(optionally including a text-to-speech module for the visually
impaired).

I'm a bit unsure if the tfa9879 sound codec binding is needed,
but I suppose it belongs in trivial-devices?

Cheers,
Peter

Peter Rosin (2):
  dt-bindings: trivial: add tfa9879 device
  ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power

 Documentation/devicetree/bindings/arm/axentia.txt  |   9 +
 .../devicetree/bindings/trivial-devices.txt        |   1 +
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/at91-natte.dtsi                  | 245 +++++++++++++++++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        | 258 +++++++++++++++++++++
 6 files changed, 516 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-natte.dtsi
 create mode 100644 arch/arm/boot/dts/at91-nattis-2-natte-2.dts

-- 
2.11.0
