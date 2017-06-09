From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 16:52:45 +0800
Subject: [PATCH v1 0/4] Patches to fix some problem for rockchip i2s
Message-ID: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to fix some problem for rockchip i2s.


Sugar Zhang (3):
  ASoC: rockchip: i2s: add a delay before i2s clear
  ASoC: rockchip: i2s: add support for i2s bclk fs configuration
  ASoC: rockchip: i2s: fixup clk div

zhangjun (1):
  ASoC: rockchip: i2s: add other configurable formats

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  2 +
 sound/soc/rockchip/rockchip_i2s.c                  | 45 +++++++++++++++++++---
 sound/soc/rockchip/rockchip_i2s.h                  |  3 ++
 3 files changed, 45 insertions(+), 5 deletions(-)

-- 
1.9.1
