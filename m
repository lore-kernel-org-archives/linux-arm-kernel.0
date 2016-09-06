From: zyw@rock-chips.com (Chris Zhong)
Date: Mon,  5 Sep 2016 21:48:53 -0700
Subject: [PATCH 0/2] Add DP dai-links to the rk3399-gru machine driver
Message-ID: <1473137335-14541-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

This series patch is for the machine driver supporting for DP.

It base on the DP drvier patches[0] and hdmi-notify patches[1], they are both
in reviewing.

[0]
https://patchwork.kernel.org/patch/9315557/
https://patchwork.kernel.org/patch/9278077/

[1]
https://patchwork.kernel.org/patch/8887261/
https://patchwork.kernel.org/patch/8887251/


Chris Zhong (2):
  drm/rockchip: cdn-dp: support audio hot-plug
  ASoC: rockchip: Add DP dai-links to the rk3399-gru machine driver

 .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 13 +++---
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  4 ++
 sound/soc/rockchip/rk3399_gru_sound.c              | 48 ++++++++++++++++++++++
 3 files changed, 59 insertions(+), 6 deletions(-)

-- 
1.9.1
