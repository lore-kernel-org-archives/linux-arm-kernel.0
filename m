From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 23 Nov 2016 17:20:38 +0100
Subject: [PATCH 0/2] minor GXL and GXM improvements
Message-ID: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds SCPI support to GXL and GXM SoCs by moving the nodes
to meson-gx.dtsi. Additionally this updates the compatible string to
match the recent changes, see [0]

Now that we have SCPI support for GXM we can also use it to configure
the CPU cores using the SCPI DVFS clocks.

[0] http://lists.infradead.org/pipermail/linux-amlogic/2016-November/001632.html

Martin Blumenstingl (2):
  ARM64: dts: meson-gx: move the SCPI and SRAM nodes to meson-gx
  ARM64: dts: meson-gxm: add SCPI configuration for GXM

 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 45 +++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 57 -----------------------------
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  9 +++++
 3 files changed, 54 insertions(+), 57 deletions(-)

-- 
2.10.2
