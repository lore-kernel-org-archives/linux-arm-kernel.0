From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 22:27:58 +0200
Subject: [PATCH 0/6] ASoC fixes from ARM randconfig builds
Message-ID: <1317587284-2776-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

As promised, here are the remaining ASoC patches from my
randconfig series. I hope I managed to get the submission
right this time. I've left out the ones that you already
took or NAKed, so this is shorter than I expected.

	Arnd

Arnd Bergmann (6):
  ASoC: codecs/wm8682: use __devexit_p
  ASoC: codecs: AK4641 depends on GPIOLIB
  ASoC: imx: eukrea_tlv320 needs i2c
  ASoC: sh: use correct __iomem annotations
  ASoC: samsung: fix Kconfig dependencies
  ASoC: samsung: add missing __devexit_p() annotations

 sound/soc/codecs/Kconfig  |    2 +-
 sound/soc/codecs/wm8782.c |    2 +-
 sound/soc/imx/Kconfig     |    1 +
 sound/soc/samsung/Kconfig |    4 ++++
 sound/soc/samsung/ac97.c  |    2 +-
 sound/soc/samsung/i2s.c   |    2 +-
 sound/soc/sh/fsi.c        |   10 +++++-----
 7 files changed, 14 insertions(+), 9 deletions(-)

-- 
1.7.5.4
