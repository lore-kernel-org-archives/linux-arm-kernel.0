From: vkale@apm.com (Vinayak Kale)
Date: Thu, 20 Mar 2014 15:17:25 +0530
Subject: [PATCH 0/2] arm64: Add PMU node for APM X-Gene Storm SoC
Message-ID: <1395308847-16317-1-git-send-email-vkale@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds PMU node for APM X-Gene's Potenza CPU.
Potenza CPU PMU is compatible with ARMv8-PMUv3.

Vinayak Kale (2):
  dt-bindings: Add Potenza PMU binding
  arm64: dts: Add PMU node for APM X-Gene Storm SOC

 Documentation/devicetree/bindings/arm/pmu.txt |    1 +
 arch/arm64/boot/dts/apm-storm.dtsi            |    5 +++++
 2 files changed, 6 insertions(+)

-- 
1.7.9.5
