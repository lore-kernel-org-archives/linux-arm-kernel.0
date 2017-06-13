From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue, 13 Jun 2017 15:27:45 +0800
Subject: [PATCH v1 0/2] Patches to add support pdm controller for rk3328
Message-ID: <1497338867-52684-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to add support pdm for rk3328 socs.


Sugar Zhang (2):
  ASoC: rockchip: add support for pdm controller
  arm64: dts: rk3328: add pdm node

 .../devicetree/bindings/sound/rockchip,pdm.txt     |  39 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  55 +++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_pdm.c                  | 516 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_pdm.h                  |  83 ++++
 6 files changed, 704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
 create mode 100644 sound/soc/rockchip/rockchip_pdm.c
 create mode 100644 sound/soc/rockchip/rockchip_pdm.h

-- 
1.9.1
