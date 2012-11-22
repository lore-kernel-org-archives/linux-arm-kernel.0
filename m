From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 22 Nov 2012 11:35:38 +0100
Subject: [PATCH 0/2] clk: ux500: Add abx500 clock driver
Message-ID: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The abx500 clocks will not be initialized from the normal clk init call.

Instead the abx500 clocks relies on the abx500-core and therfore it also
make sense to let it be a child device to it.

Right now, I am not sure of which tree to go through when merging this, but
until that is settled I hope to collect ACKs.

Upcoming series will add the abx500 clock implementations and definitions.

Ulf Hansson (2):
  clk: ux500: Initial support for abx500 clock driver
  mfd: ab8500-core: Add abx500-clk as an mfd child device

 drivers/clk/ux500/Makefile     |    3 ++
 drivers/clk/ux500/abx500-clk.c |   73 ++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/ab8500-core.c      |    4 +++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/clk/ux500/abx500-clk.c

-- 
1.7.10
