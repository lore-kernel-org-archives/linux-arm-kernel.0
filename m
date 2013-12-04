From: voice.shen@atmel.com (Bo Shen)
Date: Wed,  4 Dec 2013 10:37:02 +0800
Subject: [PATCH 0/2] ASoC: sam9x5_wm8731: fix left right channel swap issue
Message-ID: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fix sam9x5 wm8731 playback left right channel swap issue
However, sam9x5 and wm8731 only can work in DSP A mode while can not work
in I2S mode.

Bo Shen (2):
  ASoC: atmel_ssc_dai: add dai trigger ops
  ASoC: sam9x5_wm8731: change to work in DSP A mode

 sound/soc/atmel/atmel_ssc_dai.c |   30 +++++++++++++++++++++++++++++-
 sound/soc/atmel/sam9x5_wm8731.c |    2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.7.9.5
