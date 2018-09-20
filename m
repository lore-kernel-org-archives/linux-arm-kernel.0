From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 20 Sep 2018 17:57:24 +0800
Subject: [PATCH v1 0/3] update Mediatek MT2712 clock
In-Reply-To: <20180920095727.11868-1-weiyi.lu@mediatek.com>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
Message-ID: <20180920095727.11868-2-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on v4.19-rc1.
Basically, it's for the 3rd ECO design change of MT2712.
And also add support for switching pll reference source
for some MT2712 projects.

*** BLURB HERE ***

Weiyi Lu (3):
  dt-bindings: clock: add clock for MT2712
  clk: mediatek: update clock driver of MT2712
  clk: mediatek: mt2712: add pll reference support

 drivers/clk/mediatek/clk-mt2712.c      | 95 ++++++++++++++++++++++++++--------
 include/dt-bindings/clock/mt2712-clk.h |  3 +-
 2 files changed, 76 insertions(+), 22 deletions(-)

-- 
2.12.5.2.gbdf23ab
