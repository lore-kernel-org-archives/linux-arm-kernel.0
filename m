From: bhumirks@gmail.com (Bhumika Goyal)
Date: Mon, 14 Aug 2017 17:08:39 +0530
Subject: [PATCH 00/11] ASoC: make snd_soc_platform_driver const
Message-ID: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make snd_soc_platform_driver const.

Bhumika Goyal (11):
  ASoC: codecs: make snd_soc_platform_driver const
  ASoC: Intel: make snd_soc_platform_driver const
  ASoC: fsl: make snd_soc_platform_driver const
  ASoC: nuc900: make snd_soc_platform_driver const
  ASoC: omap: make snd_soc_platform_driver const
  ASoC: pxa: make snd_soc_platform_driver const
  ASoC: qcom: make snd_soc_platform_driver const
  ASoC: samsung: make snd_soc_platform_driver const
  ASoC: sh: make snd_soc_platform_driver const
  ASoC: txx9: make snd_soc_platform_driver const
  ASoC: soc-utils: make snd_soc_platform_driver const

 sound/soc/codecs/cs47l24.c                   | 2 +-
 sound/soc/codecs/rt5514-spi.c                | 2 +-
 sound/soc/codecs/wm5102.c                    | 2 +-
 sound/soc/codecs/wm5110.c                    | 2 +-
 sound/soc/fsl/imx-pcm-fiq.c                  | 2 +-
 sound/soc/fsl/mpc5200_dma.c                  | 2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 sound/soc/intel/baytrail/sst-baytrail-pcm.c  | 2 +-
 sound/soc/intel/haswell/sst-haswell-pcm.c    | 2 +-
 sound/soc/intel/skylake/skl-pcm.c            | 2 +-
 sound/soc/nuc900/nuc900-pcm.c                | 2 +-
 sound/soc/omap/omap-pcm.c                    | 2 +-
 sound/soc/pxa/mmp-pcm.c                      | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c                   | 2 +-
 sound/soc/qcom/lpass-platform.c              | 2 +-
 sound/soc/samsung/idma.c                     | 2 +-
 sound/soc/sh/dma-sh7760.c                    | 2 +-
 sound/soc/sh/fsi.c                           | 2 +-
 sound/soc/sh/rcar/core.c                     | 2 +-
 sound/soc/soc-utils.c                        | 2 +-
 sound/soc/txx9/txx9aclc.c                    | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

-- 
1.9.1
