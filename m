From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 31 Aug 2013 12:44:35 +0200
Subject: [PATCH 0/3] ASoC: generic simple sound card DT bindings
Message-ID: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patches were already in the fsl-ssi ac97 series. I moved the seperated
simple sound card DT driver into the existing simple card driver.

Regards,

Markus


Markus Pargmann (3):
      ASoC: generic: simple card, use private data
      ASoC: generic simple sound card DT bindings
      ASoC: fsl: Kconfig, visible config items for simple card

 .../bindings/sound/generic,simple-dt-card.txt      |  28 +++
 include/sound/simple_card.h                        |   4 -
 sound/soc/fsl/Kconfig                              |  23 ++-
 sound/soc/generic/Kconfig                          |   1 +
 sound/soc/generic/simple-card.c                    | 225 ++++++++++++++++++---
 5 files changed, 246 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/generic,simple-dt-card.txt
