From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 13 Feb 2018 22:01:53 +0900
Subject: [PATCH v3 0/3] add UniPhier audio nodes
Message-ID: <20180213130156.27827-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device-tree nodes for Socionext audio system
for UniPhier LD11/LD20 SoCs. This one enables I2S output for
Line-In, Line-Out, S/PDIF output and compress audio output.

Katsuhiro Suzuki (3):
  arm64: dts: uniphier: add sound node for UniPhier
  arm64: dts: uniphier: add speaker out for UniPhier LD11/LD20 boards
  arm64: dts: uniphier: add compress audio out for UniPhier LD11/LD20

 .../boot/dts/socionext/uniphier-ld11-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 92 +++++++++++++++++++++
 .../boot/dts/socionext/uniphier-ld20-global.dts    | 62 ++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 96 ++++++++++++++++++++++
 4 files changed, 312 insertions(+)

-- 
2.15.1
