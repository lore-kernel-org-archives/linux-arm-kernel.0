From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 9 Feb 2015 17:02:49 +0800
Subject: [PATCH 0/3] ARM: at91: at91sam9n12ek: enable usb gadget support
Message-ID: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable the usb gadget support on at91sam9n12ek
board. On at91sam9n12 SoC which integrate the full speed udc device.


Bo Shen (3):
  USB: gadget: at91_udc: add at91sam9n12 support
  ARM: at91: dt: at91sam9n12: add udp device node
  ARM: at91: dt: at91sam9n12ek: enable udp

 arch/arm/boot/dts/at91sam9n12.dtsi  | 9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts | 5 +++++
 drivers/usb/gadget/udc/at91_udc.c   | 9 ++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.3.0.rc0
