From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Mar 2016 19:13:37 +0200
Subject: [PATCH 0/3] clk: sunxi: Add the clocks used for audio/video on sun8i
Message-ID: <cover.1459358017.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces a part of a previous series about
"Add a DRM display driver to the Allwinner H3".

I will resubmit the H3 DRM video driver and also submit the H3
components for audio on HDMI as soon as the HDMI PHY of the H3
(and A64) will be known.

Changes:
- simplify and use the 'recalc' callback (Chen-Yu Tsai)
- add a SoC type in the compatibles (Maxime Ripard)
- audio PLL added

Jean-Francois Moine (3):
  clk: sunxi: Add sun6i/8i display support
  clk: sunxi: Add sun6i/8i PLL video support
  clk: sunxi: Add sun8i PLL audio support

 Documentation/devicetree/bindings/clock/sunxi.txt |   3 +
 drivers/clk/sunxi/clk-sunxi.c                     | 151 ++++++++++++++++++++++
 2 files changed, 154 insertions(+)

-- 
2.8.0
