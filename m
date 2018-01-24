From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 24 Jan 2018 15:10:58 +0100
Subject: [PATCH 0/3] ASoC: sun4i-i2s: Updates to the driver
Message-ID: <20180124141101.12867-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,

here is a patch series to add some improvements to the sun4i-i2s driver
found whilst getting slave clocking and hdmi audio working on the newer
SoCs.
This has been tested on a Pine64 using the ES9023 audio POT board
(https://github.com/codekipper/linux-sunxi/commits/upstream)
BR,
CK

Marcus Cooper (3):
  ASoC: sun4i-i2s: Add set_tdm_slot functionality
  ASoC: sun4i-i2s: Do not divide clocks when slave
  ASoC: sun4i-i2s: Add regmap field to sign extend sample

 sound/soc/sunxi/sun4i-i2s.c | 154 ++++++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 54 deletions(-)

-- 
2.16.0
