From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  6 Nov 2015 09:38:08 +0800
Subject: [PATCH v3 0/3] ASoC: rockchip: i2s: add 8 channels capture support
 and share lrck
Message-ID: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support 8 channels capture support.
share lrck tx/rx when symmetric_rates enabled.

Sugar Zhang (3):
  ASoC: rockchip: i2s: add 8 channels capture support
  Documentation: DT bindings: rockchip-i2s: add capture property
  ASoC: rockchip: i2s: share tx/rx lrck when symmetric_rates enabled

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
 sound/soc/rockchip/rockchip_i2s.c                  | 48 +++++++++++++++++++++-
 sound/soc/rockchip/rockchip_i2s.h                  | 16 ++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.3.6
