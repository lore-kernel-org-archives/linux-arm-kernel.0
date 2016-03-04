From: eric@anholt.net (Eric Anholt)
Date: Fri,  4 Mar 2016 12:32:05 -0800
Subject: [PATCH 0/3] ARM: bcm2835: Include VC4 GPU in the DT
Message-ID: <1457123528-13482-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been floating around out of tree, and the Pi Foundation is
including a variant of it in the device tree overlay in its firmware
update system.

Eric Anholt (3):
  dt-bindings: Add binding docs for V3D.
  drm/vc4: Recognize a more specific compatible string for V3D.
  ARM: bcm2835: Add VC4 to the device tree.

 .../devicetree/bindings/display/brcm,bcm-vc4.txt   | 12 ++++++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  4 ++
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  4 ++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  9 +++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |  4 ++
 arch/arm/boot/dts/bcm283x.dtsi                     | 47 ++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  1 +
 10 files changed, 93 insertions(+)

-- 
2.7.0
