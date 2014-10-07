From: jay.xu@rock-chips.com (Jianqun)
Date: Tue,  7 Oct 2014 09:43:55 +0800
Subject: [PATCH 0/2] rockchip-max98090: add driver for rockchip board with
 max98090
Message-ID: <1412646237-9369-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches add driver for rockchip board using a max98090. This could be
replaced with simple-card driver but it not work well now.

Tested on RK3288 using a max98090.


Jianqun (2):
  ASoC: rockchip-max98090: add driver for rockchip board using a
    max98090
  ASoC: rockchip-max98090: add documentation for rockchip-max98090
    driver

 .../sound/rockchip,rockchip-audio-max98090.txt     |  23 ++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   5 +-
 sound/soc/rockchip/rockchip_max98090.c             | 346 +++++++++++++++++++++
 4 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.txt
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c

-- 
1.9.1
