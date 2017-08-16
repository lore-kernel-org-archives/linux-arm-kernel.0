From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:45:07 +0530
Subject: [PATCH 0/2] ASoC: make snd_soc_dai_driver and
 snd_soc_component_driver const
Message-ID: <1502903709-7411-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const.

Bhumika Goyal (2):
  ASoC: bcm: make snd_soc_dai_driver const
  ASoC: codecs: make snd_soc_dai_driver and snd_soc_component_driver
    const

 sound/soc/bcm/cygnus-ssp.c    | 2 +-
 sound/soc/codecs/hdmi-codec.c | 2 +-
 sound/soc/codecs/lm4857.c     | 2 +-
 sound/soc/codecs/max9768.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.9.1
