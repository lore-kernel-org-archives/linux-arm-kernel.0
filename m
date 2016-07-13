From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 13 Jul 2016 12:25:37 +0200
Subject: [PATCH v3 0/2] ASoC: add driver for Atmel I2S controller
Message-ID: <cover.1468405019.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds support to the new Atmel I2S controller
embedded on sama5d2 SoCs.

ChangeLog

v2 -> v3
- fix the coding style, add some more comments and add a section dedicated
  to sama5d2 SoCs in the DT binding documentation as suggested by Mark
  Brown.

v1 -> v2
- initialize dev->dev before calling dev->caps->mck_init()

Cyrille Pitchen (2):
  ASoC: atmel-i2s: add DT bindings for I2S controller
  ASoC: atmel-i2s: add driver for the new Atmel I2S controller

 .../devicetree/bindings/sound/atmel-i2s.txt        |  87 +++
 sound/soc/atmel/Kconfig                            |   9 +
 sound/soc/atmel/Makefile                           |   2 +
 sound/soc/atmel/atmel-i2s.c                        | 770 +++++++++++++++++++++
 4 files changed, 868 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
 create mode 100644 sound/soc/atmel/atmel-i2s.c

-- 
1.8.2.2
