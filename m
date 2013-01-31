From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 31 Jan 2013 11:53:36 +0800
Subject: [PATCH 0/4] ASoC: atmel: fixes for working as module
Message-ID: <1359604420-15171-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches fixes the audio part when working as module

Bo Shen (4):
  ASoC: atmel_pcm: make it buildable as module
  ASoC: atmel_ssc_dai: remove error set private data
  ASoC: atmel_ssc_dai: correct sequence when unload
  ASoC: sam9g20_wm8731: disable clock and correct sequence when unload

 sound/soc/atmel/atmel-pcm.h      |    6 ++++--
 sound/soc/atmel/atmel_ssc_dai.c  |   12 +-----------
 sound/soc/atmel/sam9g20_wm8731.c |    6 +++---
 3 files changed, 8 insertions(+), 16 deletions(-)

-- 
1.7.9.5
