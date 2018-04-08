From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sun, 8 Apr 2018 14:56:57 +0000
Subject: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
Message-ID: <20180408145700.23520-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
  The first patch is a trivial typo fix, I can fold the first two patches
together if necessary.

Yixun Lan (3):
  dt-bindings: interrupt-controller: fix the double quotes
  dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
  irqchip/meson-gpio: add support for Meson-AXG SoCs

 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
 drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.16.2
