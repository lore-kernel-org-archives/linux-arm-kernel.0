From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 15:02:34 +0100
Subject: [PATCH 0/3] ARM: dts: at91: add more devices to sama5d2 Xplained
Message-ID: <cover.1456840819.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This little series is for adding more nodes to the SAMA5D2 Xplained board and
complete the USB ones.

Cyrille Pitchen (1):
  ARM: dts: at91: sama5d2 Xplained: set pin muxing for usb gadget and
    usb host

Ludovic Desroches (1):
  ARM: dts: at91: sama5d2 Xplained: add user push button

Wenyou Yang (1):
  ARM: dts: at91: sama5d2 Xplained: add leds node

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

-- 
2.1.3
