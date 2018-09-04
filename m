From: argus.lin@mediatek.com (Argus Lin)
Date: Tue, 4 Sep 2018 20:31:51 +0800
Subject: [PATCH 0/3] Pwrap: Mediatek pwrap driver for mt6765
Message-ID: <1536064314-31967-1-git-send-email-argus.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's version 1 of the patch series, include 3 patches:
1.Modify dt-bindings document/pwrap.txt to add mt6765 SoCs.
2.Add pwrap driver for mt6765 SoCs.
3.Add mt6357 driver for mt6765 SoCs.

Argus Lin (3):
  dt-bindings: pwrap: mediatek: add pwrap support for MT6765
  soc: mediatek: pwrap: add pwrap driver for mt6765 SoCs
  soc: mediatek: pwrap: add mt6357 driver for mt6765 SoCs

 .../devicetree/bindings/soc/mediatek/pwrap.txt     |  1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 84 +++++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

-- 
1.8.1.1.dirty
