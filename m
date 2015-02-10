From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 10 Feb 2015 09:55:33 +0800
Subject: [PATCH v2 0/2] ARM: at91: dt: at91sam9n12ek: enable udp device
Message-ID: <1423533335-25135-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enable usb device support on at91sam9n12ek board.

Changes in v2:
  - Base on next-20150209 (so, remove the modification of udc driver).
  - Add pinctrl for usb1 vbus sense.

Bo Shen (2):
  ARM: at91: dt: at91sam9n12: add udp device node
  ARM: at91: dt: at91sam9n12ek: enable udp

 arch/arm/boot/dts/at91sam9n12.dtsi  |  9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.3.0.rc0
