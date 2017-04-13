From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 13 Apr 2017 15:33:04 +0800
Subject: [PATCH 0/3] Fix mdp device tree
Message-ID: <1492068787-17838-1-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix this by moving the mdp component nodes up a level such that they are
siblings of mdp and all other SoC subsystems.  This also simplifies the
device tree.

Daniel Kurtz (2):
  arm64: dts: mt8173: Fix mdp device tree
  media: mtk-mdp: Fix mdp device tree

Minghsiu Tsai (1):
  dt-bindings: mt8173: Fix mdp device tree

 .../devicetree/bindings/media/mediatek-mdp.txt     |  12 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 126 ++++++++++-----------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |   2 +-
 3 files changed, 64 insertions(+), 76 deletions(-)

-- 
1.9.1
