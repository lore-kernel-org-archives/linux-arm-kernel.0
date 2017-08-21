From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 21 Aug 2017 16:25:05 +0800
Subject: [PATCH v2 0/2] Patches to add support pdm controller for rk3328
Message-ID: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches to add support pdm for rk3328 socs.

Changes in v2:
- separate pinctrl pins
  remove unused fsync clk, it's debug pins

Sugar Zhang (2):
  arm64: dts: rockchip: add rk3328 pdm node
  ASoC: rockchip: separate pinctrl pins from each other

 .../devicetree/bindings/sound/rockchip,pdm.txt     |  7 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 77 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

-- 
2.7.4
