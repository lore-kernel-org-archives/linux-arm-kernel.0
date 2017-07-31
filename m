From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 31 Jul 2017 16:22:10 +0800
Subject: [PATCH 0/3] PINCTRL: Mediatek pinctrl driver for mt2712 
Message-ID: <1501489333-23145-1-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes three patches:
1.Add mt2712 compatible node in binding document.
2.Add mt2712 pinctrl device node.
3.Add mt2712 pinctrl driver.

Zhiyong Tao (3):
  dt-bindings: pinctrl: mt2712: add binding document
  arm64: dts: mt2712: add pintcrl device node.
  pinctrl: add mt2712 pinctrl driver

 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    1 +
 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h      | 1014 +++++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   18 +
 drivers/pinctrl/mediatek/Kconfig                   |    8 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |   21 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |  670 +++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |   16 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   44 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h      | 1858 ++++++++++++++++++++
 10 files changed, 3619 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h

--
1.9.1
