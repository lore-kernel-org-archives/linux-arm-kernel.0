From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 31 Aug 2018 17:02:15 +0200
Subject: [PATCH 0/3] arm64: dts: meson-axg: add pdm support
Message-ID: <20180831150218.8307-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds pdm support for amlogic AXG SoC.
It applies on top of the DT clean-up [0] I sent earlier

The related ASoC PDM patches can be found here [1]. While the ASoC patches
[2] are obviously needed to for the PDM to work, this series can be safely
applied without it.

[0]: https://lkml.kernel.org/r/20180829154551.26729-1-jbrunet at baylibre.com
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-4.20
[2]: https://lkml.kernel.org/r/20180829150051.18190-1-jbrunet at baylibre.com

Jerome Brunet (3):
  arm64: dts: meson-axg: add pdm
  arm64: dts: meson-axg: s400: add dmic codec
  arm64: dts: meson-axg: s400: add pdm to the sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 27 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 12 +++++++++
 2 files changed, 39 insertions(+)

-- 
2.17.1
