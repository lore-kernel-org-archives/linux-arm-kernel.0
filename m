From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 May 2015 12:53:41 +0200
Subject: ARM64: dts: Mediatek: MT8173 updates
Message-ID: <1432032824-7955-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series contains dts updates for Mediatek MT8173 for Linux 4.2.
The clock code and the PMIC wrapper are sitting in Linux next, this
series adds the dts updates to make use of this code.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      ARM64: dts: mt8173: Add clock controller device nodes
      ARM64: dts: mt8173: Use real clock for UARTs
      ARM64: dts: mt8173: Add PMIC wrapper device node

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 61 +++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 5 deletions(-)
