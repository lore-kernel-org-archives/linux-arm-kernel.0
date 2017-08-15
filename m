From: jun.gao@mediatek.com (Jun Gao)
Date: Tue, 15 Aug 2017 21:08:13 +0800
Subject: [PATCH v3 0/2] Add i2c dt-binding and compatible for Mediatek MT7622
 SoC
Message-ID: <1502802495-5064-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.13-rc1, include MT7622 i2c dt-binding
and compatible.

changes since v2:
- Remove all the length settings from mt7622_i2c_quirks

changes since v1:
- Modify commit message
- Revise dt-binding documentation

Jun Gao (2):
  dt-bindings: i2c: Add MediaTek MT7622 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT7622

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
 drivers/i2c/busses/i2c-mt65xx.c                   | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

--
1.8.1.1
