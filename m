From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 08:05:49 +0900
Subject: [PATCH v6 0/2] clk: shmobile: r8a7779: Add clocks support
Message-ID: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

please consider applying this series.

It is the first step on the way towards using the common clock framework
and in turn multi-platform on the r8a7779 (R-Car H1) SoC.

It has been acked by Laurent Pinchart who did similar work
for the R-Car Gen-2 family of SoCs. This work is based on that work.

The bindings added in this series have not been changed since
v4 was posted with devicetree at vger.kernel.org CCed on the 13th of March.

Simon Horman (2):
  clk: shmobile: r8a7779: Add clocks support
  clk: shmobile: r8a7779: Add MSTP clock support

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
 .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  27 ++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7779.c                 | 180 +++++++++++++++++++++
 include/linux/clk/shmobile.h                       |   3 +
 5 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7779.c

-- 
1.8.4
