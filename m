From: fkan@apm.com (Feng Kan)
Date: Mon, 27 Oct 2014 12:28:21 -0700
Subject: [PATCH RESEND 0/7] APM X-Gene SoC platform device tree cleanup
Message-ID: <1414438108-8384-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sums up the dts changes of the recent committed drivers into the kernel.
This will grant PMU, reboot, USB and gpio functionalities to the platform.
These patches are all based on existing and approved driver that is in the
kernel tree today.

Feng Kan (7):
  arm64: dts: Add APM X-Gene USB 2.0 DTS node
  Documentation: arm64: add SCU dts binding documentation to linux
    kernel
  arm64: dts: Add X-Gene reboot driver dts node
  arm64: dts: Add Designware GPIO dts binding to APM X-Gene platform
  arm64: dts: Add APM X-Gene SoC GFC GPIO controller DTS entries
  Documentation: arm: pmu: Add Potenza PMU binding
  arm64: dts: Add PMU node for APM X-Gene Storm SOC

 Documentation/devicetree/bindings/arm/apm/scu.txt | 17 ++++++++
 Documentation/devicetree/bindings/arm/pmu.txt     |  1 +
 arch/arm64/boot/dts/apm-storm.dtsi                | 53 +++++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt

-- 
1.9.1
