From: jun.gao@mediatek.com (Jun Gao)
Date: Mon, 21 Aug 2017 11:36:51 +0800
Subject: [PATCH v4 0/3] Add i2c dt-binding and compatible for Mediatek MT7622
 SoC
Message-ID: <1503286614-17670-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.13-rc1, include i2c binding file information
formats modification, MT7622 i2c dt-binding and compatible.

changes since v3:
- Split the formats modification into another patch

changes since v2:
- Remove all the length settings from mt7622_i2c_quirks

changes since v1:
- Modify commit message
- Revise dt-binding documentation

Jun Gao (3):
  dt-bindings: i2c: modify information formats
  dt-bindings: i2c: Add MediaTek MT7622 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT7622

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 15 ++++++++-------
 drivers/i2c/busses/i2c-mt65xx.c                   | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

--
1.8.1.1
