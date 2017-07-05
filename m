From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed,  5 Jul 2017 17:43:21 +0200
Subject: [PATCH 0/3] ASoC: Add I2S support for Allwinner H3 SoCs
Message-ID: <20170705154324.14565-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
please find attached a series of patches to bring i2s support to the
Allwinner H3 SoC. This has been tested with the following setups:

A20 Olimex EVB connected to a pcm5102
Orange Pi 2 connected to a uda1380
Orange Pi 2 hdmi audio playback
Pine 64 connected to the audio DAC board

To get i2s working some additional patches are required which will be
delivered later. For now they have been pushed here

https://github.com/codekipper/linux-sunxi/commits/sunxi-audio-h3

Thanks in advance,
CK

Marcus Cooper (3):
  ASoC: sun4i-i2s: Add more quirks for newer SoCs
  ASoC: sun4i-i2s: Get startup to call set_fmt
  ASoC: sun4i-i2s: Add support for H3

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 391 ++++++++++++++++++++-
 2 files changed, 376 insertions(+), 17 deletions(-)

-- 
2.13.2
