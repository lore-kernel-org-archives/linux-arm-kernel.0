From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 18:16:33 +0200
Subject: [PATCH 0/2] Add TVE to i.MX53-QSB device tree
Message-ID: <1365437795-30074-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

these two patches add the necessary TVE device tree nodes to the
i.MX53 dtsi and to the i.MX53-QSB dts, including pin configuration
for HSYNC and VSYNC pins.

regards
Philipp

---
 arch/arm/boot/dts/imx53-qsb.dts |   25 +++++++++++++++++++++++--
 arch/arm/boot/dts/imx53.dtsi    |   10 ++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)
