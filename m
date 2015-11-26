From: biao.huang@mediatek.com (Biao Huang)
Date: Thu, 26 Nov 2015 16:44:27 +0800
Subject: [PATCH 0/5] pinctrl: mediatek: add pinctrl/GPIO/EINT driver for
 mt2701
Message-ID: <1448527472-20651-1-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 pinctrl/eint are similar to mt8127, mt8135 and mt8173,
add support for mt2701 using mediatek common pinctrl driver.

Biao Huang (4):
  dt-bindings: mediatek: Modify pinctrl bindings for mt2701
  pinctrl: dt bindings: Add pinfunc header file for mt2701
  pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver for mt2701
  arm: dts: Add pinctrl/GPIO/EINT node for mt2701

Erin Lo (1):
  ARM: mediatek: Add MT2701 config options for mediatek SoCs.

 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |    9 +-
 arch/arm/boot/dts/mt2701-pinfunc.h                 |  713 ++++++
 arch/arm/boot/dts/mt2701.dtsi                      |   19 +
 arch/arm/mach-mediatek/Kconfig                     |    4 +
 drivers/pinctrl/mediatek/Kconfig                   |    6 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |  571 +++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |    7 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |    3 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h      | 2323 ++++++++++++++++++++
 10 files changed, 3652 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt2701-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2701.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h

-- 
1.7.9.5
