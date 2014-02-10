From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 10 Feb 2014 14:09:44 +0800
Subject: [PATCH v3 0/2] ASoC: atmel_ssc_dai: add option to choose clock
Message-ID: <1392012586-30790-1-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When SSC work in slave mode, the clock can come from TK pin and also
can come from RK pin, this is hardware design decided. So, make it
available to choose where the clock from.

Changes in v3:
  - Move the property from card to ssc device
Series-changes: 2
  - using "-" replace "_" in binding document

Bo Shen (2):
  ASoC: atmel_ssc_dai: make option to choose clock
  Binding: atmel-ssc: add option to choose clock

 Documentation/devicetree/bindings/misc/atmel-ssc.txt |  8 ++++++++
 drivers/misc/atmel-ssc.c                             |  6 ++++++
 include/linux/atmel-ssc.h                            |  1 +
 sound/soc/atmel/atmel_ssc_dai.c                      | 13 +++++++++----
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
1.8.5.2
