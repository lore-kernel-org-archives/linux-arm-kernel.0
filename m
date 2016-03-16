From: ashoks@broadcom.com (Ashok Kumar)
Date: Wed, 16 Mar 2016 06:01:44 -0700
Subject: [PATCH 0/5] arm64: perf: Broadcom Vulcan PMU support
Message-ID: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Broadcom Vulcan PMU. It supports most of the
ARMv8 recommended implementation defined events.

Added macros for complete ARMv8 recommended implementation defined events.

Cleaned up event naming convention for uniformity.

This patchset is created against linux-next. 


Ashok Kumar (5):
  arm64/perf: Changed events naming convention for uniformity
  arm64/perf: Define complete ARMv8 recommended implementation defined
    events
  arm64/perf: Add Broadcom Vulcan PMU support
  arm64: dts: Add Broadcom Vulcan PMU in dts
  Documentation: arm64: pmu: Add Broadcom Vulcan PMU binding

 Documentation/devicetree/bindings/arm/pmu.txt |   3 +-
 arch/arm64/boot/dts/broadcom/vulcan.dtsi      |   2 +-
 arch/arm64/kernel/perf_event.c                | 537 +++++++++++++++++++++-----
 3 files changed, 438 insertions(+), 104 deletions(-)

-- 
2.1.0
