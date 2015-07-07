From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  7 Jul 2015 14:45:09 +0200
Subject: Mediatek MT8135 dts updates
Message-ID: <1436273113-25472-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains dts updates for the Mediatek MT8135 to enable
recently added Kernel features. Last time I sent this the dt-include
files were missing. This time this should be ready to get merged.

Sascha

----------------------------------------------------------------
James Liao (1):
      ARM: dts: mediatek: Enable clock support for Mediatek MT8135.

Sascha Hauer (3):
      ARM: dts: mt8135: Add pmic wrapper nodes
      ARM: dts: mt8135-evbp1: Add PMIC support
      ARM: dts: mediatek mt8135: Use real UART clocks

 arch/arm/boot/dts/mt8135-evbp1.dts | 193 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |  58 +++++++++--
 2 files changed, 244 insertions(+), 7 deletions(-)
