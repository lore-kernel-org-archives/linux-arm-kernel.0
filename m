From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 22 Feb 2016 15:56:53 +0800
Subject: [PATCH v1 0/2] patches to add support for rockchip rt5640 card
Message-ID: <1456127815-68575-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add default values for i2s registers from TRM.
rt5640: add master clock handing.


Sugar Zhang (2):
  ASoC: rockchip: i2s: add default values for registers
  ASoC: rt5640: add master clock handling for rt5640

 Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++
 sound/soc/codecs/rt5640.c                          | 31 ++++++++++++++++++++++
 sound/soc/codecs/rt5640.h                          |  2 ++
 sound/soc/rockchip/rockchip_i2s.c                  | 10 +++++++
 4 files changed, 46 insertions(+)

-- 
1.9.1
