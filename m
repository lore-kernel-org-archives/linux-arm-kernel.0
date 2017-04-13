From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 13 Apr 2017 15:05:06 +0800
Subject: [PATCH 0/2] hwrng: mtk: add support for hardware random generator on
 MT7623 SoC
Message-ID: <1492067108-14748-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces support for Mediatek hardware random generator (RNG)
Currently, the driver is already tested successfully with rng-tools on MT7623
SoC. And it should also be workable on other similar Mediatek SoCs.

SoC that also works on other similar SoCs. 
Sean Wang (2):
  dt-bindings: hwrng: Add Mediatek hardware random generator bindings
  hwrng: mtk: Add driver for hardware random generator on MT7623 SoC

 Documentation/devicetree/bindings/rng/mtk-rng.txt |  18 +++
 drivers/char/hw_random/Kconfig                    |  16 +-
 drivers/char/hw_random/Makefile                   |   2 +-
 drivers/char/hw_random/mtk-rng.c                  | 174 ++++++++++++++++++++++
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/mtk-rng.txt
 create mode 100644 drivers/char/hw_random/mtk-rng.c

-- 
1.9.1
