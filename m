From: jay.xu@rock-chips.com (Jianqun)
Date: Sat, 13 Sep 2014 08:38:43 +0800
Subject: [PATCH 0/5] ASoC: rockchip-i2s: patches for rockchip i2s driver
Message-ID: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to fix rockchip i2s driver bugs, also make driver codes
reasonable.
Tested on RK3288 board.

Jianqun (5):
  ASoC: rockchip-i2s: fix rockchip i2s defination more reasonable
  ASoC: rockchip-i2s: fix master mode set bit error
  ASoC: rockchip-i2s: add dma data to snd_soc_dai
  ASoC: rockchip-i2s: fix registers' property of rockchip i2s controller
  ASoC: rockchip-i2s: enable "hclk" for rockchip I2S controller

 sound/soc/rockchip/Kconfig        |  3 +--
 sound/soc/rockchip/Makefile       |  2 +-
 sound/soc/rockchip/rockchip_i2s.c | 41 ++++++++++++++++++++++++---------------
 3 files changed, 27 insertions(+), 19 deletions(-)

-- 
1.9.1
