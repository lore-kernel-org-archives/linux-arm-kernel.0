From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  4 Apr 2014 16:14:11 -0700
Subject: [PATCH v2 0/5] ARM: zynq: DT update
Message-ID: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here's the complete series now. One fix for cpufreq from our vendor tree
and migration to pre-processor syntax.

	Thanks,
	S?ren

Changes in v2:
 - Send full series (added patches 1, 4, 5)

Soren Brinkmann (5):
  ARM: zynq: DT: Add 'clock-latency' property
  ARM: zynq: dt: Convert to preprocessor includes
  ARM: zynq: dt: Use #defines for interrupt specifiers
  dt-bindings: clock: Add Zynq-7000 header
  ARM: zynq: dt: Use #defines for clock specifiers

 arch/arm/boot/dts/zynq-7000.dtsi      | 64 ++++++++++++++++++++++-------------
 arch/arm/boot/dts/zynq-zc702.dts      |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts      |  2 +-
 arch/arm/boot/dts/zynq-zed.dts        |  2 +-
 include/dt-bindings/clock/zynq-7000.h | 64 +++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+), 27 deletions(-)
 create mode 100644 include/dt-bindings/clock/zynq-7000.h

-- 
1.9.1.1.gbb9f595
