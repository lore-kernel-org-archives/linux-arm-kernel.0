From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 28 Sep 2018 19:40:53 +0800
Subject: mmc: mediatek: add bus_clk control
Message-ID: <1538134855-11198-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Chaotian Jing (2):
  mmc: dt-bindings: add "bus-clk" for MT2712
  mmc: mediatek: add bus_clk control

 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 drivers/mmc/host/mtk-sd.c                        | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
1.8.1.1.dirty
