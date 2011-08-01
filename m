From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 1 Aug 2011 19:41:18 +0800
Subject: [PATCH 1/1] ASoC: sgtl5000: add one missed cache reg
Message-ID: <1312198878-13453-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 76258f2..5a0d8e4 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -49,6 +49,7 @@ static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
 	0x0000, /* 0x0016, reserved */
 	0x0000, /* 0x0018, reserved */
 	0x0000, /* 0x001A, reserved */
+	0x0000, /* 0x001C, reserved */
 	0x0000, /* 0x001E, reserved */
 	0x0000, /* 0x0020, CHIP_ANA_ADC_CTRL */
 	0x1818, /* 0x0022, CHIP_ANA_HP_CTRL */
-- 
1.7.0.4
