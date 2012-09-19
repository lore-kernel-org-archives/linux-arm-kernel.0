From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 19 Sep 2012 13:57:39 +0200
Subject: [PATCH v2 0/2] watchdog: at91sam9_wdt: add device tree support
Message-ID: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This set of patches is for adding device tree support to the
at91sam_wdt driver and the at91sam9260 soc.

I've tested it on an at91sam9260 board (evk-pro3).

Changes:
v2:
 - add missing to and cc addresses

Fabio Porcedda (2):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91: add at91sam9_wdt driver to at91sam9260

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                       |  6 ++++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3
