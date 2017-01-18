From: jun.gao@mediatek.com (Jun Gao)
Date: Wed, 18 Jan 2017 17:40:59 +0800
Subject: [RESEND PATCH 0/2] Add i2c DT binding and device node for Mediatek
 MT2701 Soc
Message-ID: <1484732461-13594-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.10-rc2, include MT2701 i2c DT binding and device node.

Dependent on "Add clock and power domain DT nodes for Mediatek MT2701"[1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-December/007637.html

Jun Gao (2):
  Documentation: devicetree: Add i2c binding for mediatek MT2701 Soc
    Platform
  arm: dts: mt2701: Add i2c device node

 .../devicetree/bindings/i2c/i2c-mt6577.txt         |   11 ++---
 arch/arm/boot/dts/mt2701-evb.dts                   |   44 ++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi                      |   42 +++++++++++++++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

--
1.7.9.5
