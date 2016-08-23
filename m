From: lars.persson@axis.com (Lars Persson)
Date: Tue, 23 Aug 2016 16:00:49 +0200
Subject: [PATCH 0/3] ARM: dts: artpec6.dtsi updates
Message-ID: <cover.1471959733.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings the dtsi up to date with with tested and optimized settings from the
Axis tree.

Lars Persson (3):
  ARM: dts: artpec: use clock binding header
  ARM: dts: artpec: use optimized pl310 settings
  ARM: dts: artpec: set irq affinity on pmu interrupts

 arch/arm/boot/dts/artpec6.dtsi | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

-- 
2.1.4
