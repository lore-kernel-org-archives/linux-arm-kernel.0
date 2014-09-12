From: jay.xu@rock-chips.com (Jianqun)
Date: Fri, 12 Sep 2014 15:26:46 +0800
Subject: [PATCH 0/2] rockchip-max98090: add driver for rockchip board with
 max98090
Message-ID: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch to add driver for rockchip board using a max98090.

Tested on RK3288 using a max98090.

Jianqun (2):
  ASoC: rockchip-max98090: add documentation for rockchip-max98090
    driver
  ASoC: rockchip-max98090: add driver for rockchip board using a
    max98090

 .../sound/rockchip,rockchip-audio-max98090.txt     |  23 ++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   5 +-
 sound/soc/rockchip/rockchip_max98090.c             | 308 +++++++++++++++++++++
 4 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-audio-max98090.txt
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c

-- 
1.9.1
