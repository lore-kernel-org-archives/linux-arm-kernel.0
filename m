From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 23 Apr 2015 11:21:11 +0200
Subject: Mediatek MT8135 dts updates
Message-ID: <1429780875-29096-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains the Mediatek MT8135 dts updates for the clock
support and UART support. This needs these two series:

[PATCH v12] clk: Add common clock support for Mediatek MT8135 and MT8173
tty: serial: 8250_mtk: Add support for second clock

Also this adds the PMIC wrapper nodes to the dtsi file and PMIC node to
the mt8135-evbp1 board. Support for the PMIC wrapper was merged during
the v4.1 merge window.

This series is meant for testing the new features, not (yet) for inclusion.

----------------------------------------------------------------

The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:

  Linux 4.0 (2015-04-12 15:12:50 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git tags/v4.0-mtk-arm-dts

for you to fetch changes up to 5fcd75a6aeded756c24d9581f49e0859b85fb3a0:

  ARM: dts: mediatek mt8135: Use real UART clocks (2015-04-23 11:02:27 +0200)

----------------------------------------------------------------

James Liao (1):
      ARM: dts: mediatek: Enable clock support for Mediatek MT8135.

Sascha Hauer (3):
      ARM: dts: mt8135: Add pmic wrapper nodes
      ARM: dts: mt8135-evbp1: Add PMIC support
      ARM: dts: mediatek mt8135: Use real UART clocks

 arch/arm/boot/dts/mt8135-evbp1.dts | 193 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi      |  58 ++++++++++-
 2 files changed, 247 insertions(+), 4 deletions(-)
