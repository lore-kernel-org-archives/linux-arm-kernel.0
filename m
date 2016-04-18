From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 18 Apr 2016 12:01:34 +0200
Subject: [PATCH v2 0/2] clk: Add Oxford Semiconductor OXNAS Clocks support
Message-ID: <1460973696-5977-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset includes support for the standard clocks controller for the
Oxford Semiconductor OXNAS SoC Family.

Changes since v1 clk patchset :
- Add text to Kconfig
- Clean indice-clk table
- Add single struct to have a single kzalloc

v1 clk patchset: http://lkml.kernel.org/r/1459520791-13269-1-git-send-email-narmstrong at baylibre.com

It was originally posted part of a platform patchset available here :
http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

Changes this v3 patchset :
- Get rid of PLX Technology, replace by Oxford Semiconductor

Neil Armstrong (2):
  clk: Add Oxford Semiconductor OXNAS Standard Clocks
  dt-bindings: Add Oxford Semiconductor OXNAS Standard Clocks bindings

 .../devicetree/bindings/clock/oxnas,stdclk.txt     |  35 ++++
 drivers/clk/Kconfig                                |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-oxnas.c                            | 198 +++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
 create mode 100644 drivers/clk/clk-oxnas.c

-- 
1.9.1
