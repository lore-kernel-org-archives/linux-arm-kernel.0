From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 30 Jun 2017 14:03:03 +0800
Subject: [PATCH v1 0/4] media: rc: add support for IR receiver on MT7622 SoC
Message-ID: <cover.1498794408.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces Consumer IR (CIR) support for MT7622 SoC
implements raw mode for more compatibility with different protocols
as previously SoC did. Before adding support to MT7622 SoC, extra
code refactor is done since there're major differences in register and
field definition from the previous SoC.

Sean Wang (4):
  dt-bindings: media: mtk-cir: Add support for MT7622 SoC
  media: rc: mtk-cir: add platform data to adapt into various hardware
  media: rc: mtk-cir: add support for MediaTek MT7622 SoC
  MAINTAINERS: add entry for MediaTek CIR driver

 .../devicetree/bindings/media/mtk-cir.txt          |   8 +-
 MAINTAINERS                                        |   5 +
 drivers/media/rc/mtk-cir.c                         | 242 ++++++++++++++++-----
 3 files changed, 197 insertions(+), 58 deletions(-)

-- 
2.7.4
