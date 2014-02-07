From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 21:50:24 +0100
Subject: [PATCH v2 0/2] irqchip: sun4i: Introduce a new compatible
Message-ID: <1391806226-27480-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the second version of the A10 irqchip compatible changes.
The only difference with the v1 being that we're now droping the old
compatibles, instead of keeping them, since the DT maintainers said it was
fine.

Thanks,
Maxime

Maxime Ripard (2):
  irqchip: sunxi: Change compatibles
  ARM: sunxi: dt: Convert to the new irq controller compatibles

 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 ++--
 arch/arm/boot/dts/sun4i-a10.dtsi                                      | 2 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                                     | 2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                                      | 2 +-
 drivers/irqchip/irq-sun4i.c                                           | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.4.2
