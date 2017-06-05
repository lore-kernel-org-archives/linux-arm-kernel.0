From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 21:27:19 +0800
Subject: [PATCH v4 0/3] Allwinner V3s audio codec support (ASoC part)
Message-ID: <20170605132722.6459-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ASoC part of the Allwinner V3s audio codec support.

The audio codec is like the ones on A23/H3, but much simpler.

As it lacks two features that used to be common (MIC2 and LINEIN),
some structures are altered to exclude these features.

Icenowy Zheng (3):
  ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for
    V3s
  ASoC: sun8i-codec-analog: add support for V3s SoC
  ASoC: sun4i-codec: Add support for V3s codec

 .../devicetree/bindings/sound/sun4i-codec.txt      |  11 ++-
 .../bindings/sound/sun8i-codec-analog.txt          |   1 +
 sound/soc/sunxi/sun4i-codec.c                      |  63 ++++++++++++
 sound/soc/sunxi/sun8i-codec-analog.c               | 110 ++++++++++++++++++++-
 4 files changed, 180 insertions(+), 5 deletions(-)

-- 
2.12.2
