From: zonque@gmail.com (Daniel Mack)
Date: Thu, 11 Jul 2013 17:17:52 +0200
Subject: [PATCH 0/5] Assorted patches for pxa-gpio
Message-ID: <1373555877-29887-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,
Hi Haojian,

here are some patches for gpio-pxa and its bindings. They fix some
flaws I came across while trying to boot a PXA3xx board with v3.10+.


Best regards,
Daniel

Daniel Mack (5):
  gpio: pxa: remove dead code
  gpio: pxa: fix Documentation of interrupt-names property
  gpio: pxa: Documentation: provide example bindings for PXA3xx
  ARM: pxa: fix DT auxdata for pxa3xx-gpio
  ARM: pxa: DTS: override gpio node in pxa3xx.dtsi

 .../devicetree/bindings/gpio/mrvl-gpio.txt         | 22 ++++++++++++++++++----
 arch/arm/boot/dts/pxa3xx.dtsi                      | 11 +++++++++++
 arch/arm/mach-pxa/pxa-dt.c                         |  2 +-
 drivers/gpio/gpio-pxa.c                            | 13 +++----------
 4 files changed, 33 insertions(+), 15 deletions(-)

-- 
1.8.1.4
