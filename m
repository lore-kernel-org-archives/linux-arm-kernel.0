From: fkan@apm.com (Feng Kan)
Date: Mon, 11 Aug 2014 16:47:31 -0700
Subject: [PATCH Resend 0/2] arm64: Add PMU node for APM X-Gene Storm SoC
Message-ID: <1407800853-3149-1-git-send-email-fkan@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds PMU node for APM X-Gene's Potenza CPU.
Potenza CPU PMU is compatible with ARMv8-PMUv3.

I have remove the previous notice regarding the dependancy on the GIC driver
from the commit message.

Feng Kan (1):
  dt-bindings: Add Potenza PMU binding

Vinayak Kale (1):
  arm64: dts: Add PMU node for APM X-Gene Storm SOC

 Documentation/devicetree/bindings/arm/pmu.txt | 1 +
 arch/arm64/boot/dts/apm-storm.dtsi            | 5 +++++
 2 files changed, 6 insertions(+)

-- 
1.9.1
