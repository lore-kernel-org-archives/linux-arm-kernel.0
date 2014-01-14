From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 14 Jan 2014 11:25:53 +0800
Subject: [PATCH 0/3] ASoC: atmel_ssc_dai: add option to choose clock
Message-ID: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SSC work in slave mode, the clock can come from TK pin and also
can come from RK pin, this is hardware design decided. So, make it
available to choose where the clock from.


Bo Shen (3):
  ASoC: atmel_ssc_dai: make option to choose clock
  ASoC: atmel_wm8904: make it available to choose clock
  Binding: atmel-wm8904: add option to choose clock

 Documentation/devicetree/bindings/sound/atmel-wm8904.txt |  2 ++
 sound/soc/atmel/atmel_ssc_dai.c                          | 16 ++++++++++++----
 sound/soc/atmel/atmel_ssc_dai.h                          |  1 +
 sound/soc/atmel/atmel_wm8904.c                           | 10 ++++++++++
 4 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.8.5.2
