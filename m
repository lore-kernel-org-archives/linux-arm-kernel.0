From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 27 Jan 2015 15:13:53 +0800
Subject: Add Mediatek SoC Pinctrl/GPIO/EINT driver for MT8173. 
Message-ID: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the first version of add Mediatek SoC Pinctrl/GPIO/EINT driver for MT8173.
It is base on MT8135 pinctrl driver, MT8173 has 135 pins.

Hongzhou Yang (3):
  arm64: mediatek: Add config option for mt8173.
  arm64: mediatek: Add Pinctrl/GPIO/EINT driver for mt8173.
  arm64: dts: mt8173: Add pinctrl/GPIO/EINT node for mt8173.

 arch/arm64/Kconfig                            |    6 +
 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h |  682 ++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   19 +
 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  452 +++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   14 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    7 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h | 1226 +++++++++++++++++++++++++
 9 files changed, 2411 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8173.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h

-- 
1.8.1.1.dirty
