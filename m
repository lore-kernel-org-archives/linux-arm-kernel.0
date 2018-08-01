From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  1 Aug 2018 15:40:30 +0200
Subject: [PATCH v2 0/3] arm64: dts: meson-axg: add audio support
Message-ID: <20180801134033.21739-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of this patchset is to add the audio devices on amlogic's
AXG SoCs.

In term of dependency, apart from the clock bindings you have already
pulled for your second PR to arm-soc, this patchset requires the ARB
reset bindings [0] for patch 1.

Changes since v1 [1]:
 - Dropped applied changes
 - Update card bindings following Rob's comments on the card DT binding
   documentation.

[0]: 3bfd2fe0ab49 ("reset: meson: add dt-bindings for meson-axg audio arb")
[1]: https://lkml.kernel.org/r/20180724125238.14567-1-jbrunet at baylibre.com

Jerome Brunet (3):
  arm64: dts: meson-axg: add audio fifos
  arm64: dts: meson-axg: s400: enable audio devices
  arm64: dts: meson-axg: s400: add sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 180 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  67 +++++++
 2 files changed, 247 insertions(+)

-- 
2.17.1
