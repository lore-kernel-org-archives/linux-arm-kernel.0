From: fkan@apm.com (Feng Kan)
Date: Wed,  7 Jan 2015 17:33:31 -0700
Subject: [PATCH V3 0/7] APM X-Gene SoC platform device tree cleanup
Message-ID: <1420677218-30743-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sums up the dts changes of the recent committed drivers into the kernel.
This will grant PMU, reboot, USB and gpio functionalities to the platform.
These patches are all based on existing and approved driver that is in the
kernel tree today.

V3 Changes:
	- add comments regarding usb node
	- change dwgpio node name to gpio

V2 Changes:
        - add dma-coherent attribute for usb node.

Feng Kan (7):
  arm64: dts: Add APM X-Gene USB DTS node
  Documentation: arm64: add SCU dts binding documentation to linux
    kernel
  arm64: dts: Add X-Gene reboot driver dts node
  arm64: dts: Add Designware GPIO dts binding to APM X-Gene platform
  arm64: dts: Add APM X-Gene SoC GFC GPIO controller DTS entries
  Documentation: arm: pmu: Add Potenza PMU binding
  arm64: dts: Add PMU node for APM X-Gene Storm SOC

 Documentation/devicetree/bindings/arm/apm/scu.txt |   17 ++++++
 Documentation/devicetree/bindings/arm/pmu.txt     |    1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi            |   58 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt
