From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:53 +0100
Subject: [PATCH 0/6] ASoC: samsung: Spring sound support
Message-ID: <1424283959-16289-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series prepares sound support for the HP Chromebook 11.

Regards,
Andreas


Andreas F?rber (6):
  ASoC: max98088: Document DT bindings
  ASoC: max98088: Add DT bindings
  ARM: dts: Add max98089 to exynos5250-spring
  ASoC: samsung: Document binding for max98089 based Snow driver
  ASoC: samsung: Extend Snow driver to support max98089
  ARM: dts: Add sound support to exynos5250-spring

 .../devicetree/bindings/sound/max98088.txt         | 16 ++++++++++++
 Documentation/devicetree/bindings/sound/snow.txt   |  1 +
 arch/arm/boot/dts/exynos5250-spring.dts            | 30 ++++++++++++++++++++++
 sound/soc/codecs/max98088.c                        |  8 ++++++
 sound/soc/samsung/Kconfig                          |  1 +
 sound/soc/samsung/snow.c                           |  1 +
 6 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98088.txt

-- 
2.1.4
