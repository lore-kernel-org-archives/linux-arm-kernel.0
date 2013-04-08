From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon,  8 Apr 2013 16:46:18 +0200
Subject: [PATCH 0/5] i.MX53 TVE clock patches
Message-ID: <1365432383-7787-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the first two are just cleanups, the following three patches are changes
to the i.MX53 clock tree that are necessary to use the TVEv2 module as
VGA output on the Freescale i.MX53-QSB or TQ MBa53 boards.

regards
Philipp

---
 Documentation/devicetree/bindings/clock/imx5-clock.txt |  1 -
 arch/arm/mach-imx/clk-imx51-imx53.c                    | 17 ++++++++---------
 2 files changed, 8 insertions(+), 10 deletions(-)
