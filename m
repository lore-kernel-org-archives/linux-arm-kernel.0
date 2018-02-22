From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 22 Feb 2018 13:48:46 +0800
Subject: [PATCH v1 0/5] update Mediatek MT2712 clock and scpsys support
In-Reply-To: <20180222054851.26096-1-weiyi.lu@mediatek.com>
References: <20180222054851.26096-1-weiyi.lu@mediatek.com>
Message-ID: <20180222054851.26096-2-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
Basically, all changes are for the ECO design change of MT2712.

Weiyi Lu (5):
  dt-bindings: soc: update MT2712 power dt-bindings
  soc: mediatek: update power domain data of MT2712
  dt-bindings: clock: add clocks for MT2712
  arm64: dts: add clock device nodes of MT2712
  clk: mediatek: update clock driver of MT2712

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |  28 +++
 drivers/clk/mediatek/clk-mt2712.c         |  69 +++++--
 drivers/soc/mediatek/mtk-scpsys.c         |  42 ++++-
 include/dt-bindings/clock/mt2712-clk.h    | 294 +++++++++++++++---------------
 include/dt-bindings/power/mt2712-power.h  |   3 +
 5 files changed, 277 insertions(+), 159 deletions(-)

-- 
2.12.5
