From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Wed, 23 Sep 2015 11:41:21 +0800
Subject: [PATCH 0/2] ASoC: rockchip: i2s: add 8 channels capture and lrck-mode
Message-ID: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support max 8 channels capture.
support lrck clk mode configuration, there are 3 modes:

 - txrx: lrck_tx and lrck_rx are different.
 - tx_share: lrck_tx is shared with lrck_rx.
 - rx_share: lrck_rx is shared with lrck_tx.

Sugar Zhang (2):
  ASoC: rockchip: i2s: add 8 channels capture and lrck-mode support
  Documentation: DT bindings: rockchip-i2s: add capture and lrck-mode

 .../devicetree/bindings/sound/rockchip-i2s.txt     |  5 +++
 sound/soc/rockchip/rockchip_i2s.c                  | 48 +++++++++++++++++++++-
 sound/soc/rockchip/rockchip_i2s.h                  | 23 +++++++++++
 3 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.3.6
