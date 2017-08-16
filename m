From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 16 Aug 2017 22:29:23 +0530
Subject: [PATCH 0/7] ASoC: make snd_soc_ops const
Message-ID: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make these const. Done using Coccinelle.

Bhumika Goyal (7):
  ASoC: aux1x: make snd_soc_ops const
  ASoC: cirrus: make snd_soc_ops const
  ASoC: generic: make snd_soc_ops const
  ASoC: pxa: make snd_soc_ops const
  ASoC: rockchip: make snd_soc_ops const
  ASoC: samsung: make snd_soc_ops const
  ASoC: sh: make snd_soc_ops const

 sound/soc/au1x/db1200.c                  | 2 +-
 sound/soc/cirrus/edb93xx.c               | 2 +-
 sound/soc/cirrus/snappercl15.c           | 2 +-
 sound/soc/generic/audio-graph-card.c     | 2 +-
 sound/soc/generic/audio-graph-scu-card.c | 2 +-
 sound/soc/pxa/raumfeld.c                 | 2 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c  | 2 +-
 sound/soc/samsung/jive_wm8750.c          | 2 +-
 sound/soc/samsung/s3c24xx_simtec.c       | 2 +-
 sound/soc/samsung/s3c24xx_uda134x.c      | 2 +-
 sound/soc/samsung/smdk_spdif.c           | 2 +-
 sound/soc/sh/migor.c                     | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

-- 
1.9.1
