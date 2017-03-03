From: jun.gao@mediatek.com (Jun Gao)
Date: Fri, 3 Mar 2017 10:05:11 +0800
Subject: [PATCH v3 0/2] Add i2c dt-binding and device node for Mediatek MT2701
 Soc
Message-ID: <1488506713-20767-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.10-rc2, include MT2701 i2c dt-binding
and device node.

changes since v2:
- Modify commit message
- Revise dt-binding documentation

changes since v1:
- Modify commit message

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Jun Gao (2):
  dt-bindings: i2c: Add Mediatek MT2701 i2c binding
  arm: dts: Add Mediatek MT2701 i2c device node

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++---
 arch/arm/boot/dts/mt2701-evb.dts                   |   44 ++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      |   42 +++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

--
1.7.9.5
