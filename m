From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri,  9 Dec 2016 15:28:29 +0900
Subject: [PATCH 0/4] dt-bindings: mfd: Update TPS65217 interrupts
Message-ID: <20161209062833.5768-1-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set fixes wrong property name and uses TPS65217 HW interrupt 
number from the datasheet instead of the DT ABI. DT bindings are also 
updated.

Milo Kim (4):
  ARM: dts: am335x: Fix the interrupt name of TPS65217
  dt-bindings: mfd: Remove TPS65217 interrupts
  dt-bindings: power/supply: Update TPS65217 properties
  dt-bindings: input: Add interrupt number for TPS65217

 .../bindings/input/tps65218-pwrbutton.txt          |  4 +++-
 .../bindings/power/supply/tps65217_charger.txt     |  7 +++++-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  8 +++----
 include/dt-bindings/mfd/tps65217.h                 | 26 ----------------------
 4 files changed, 12 insertions(+), 33 deletions(-)
 delete mode 100644 include/dt-bindings/mfd/tps65217.h

-- 
2.9.3
