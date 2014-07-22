From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:06 +0100
Subject: [PATCH 00/19] mfd: Fix checkpatch errors
Message-ID: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm going through the subsystem rectifying all of the warnings/errors
checkpatch finds.  Please review as appropriate.

Lee Jones (19):
  mfd: max77686: Fix 'line over 80 chars' warning
  mfd: max8925-i2c: Fix 'blank line after declarations' warning
  mfd: tps80031: Fix 'missing break or fall-through comment' warning
  mfd: mcp-core: Fix 'blank line after declarations' warning
  mfd: wm8350-irq: Fix 'line over 80 chars' warning
  mfd: dm355evm_msp: Fix checkpatch error: insert space after ','
  mfd: sec-core: Fix 'missing blank line after declarations' warning
  mfd: twl6040: Fix 'insert space after ','', error
  mfd: ezx-pcap: Repair coding style errors picked up with checkpatch
  mfd: lp8788-irq: Fix 'missing blank line after declarations' warning
  mfd: twl4030-irq: Fix style warnings relating to pr_warn() and sizeof()
  mfd: max8925-core: Fix 'missing blank line after declarations' warning
  mfd: wm8350-i2c: Replace spaces with tabs
  mfd: twl6030-irq: Extinguish coding style warnings
  mfd: tc6387xb: Remove unnecessary braces and correct style warnings
  mfd: si476x-cmd: Remedy checkpatch style complains
  mfd: ipaq-micro: Fix coding style errors/warnings reported by checkpatch
  mfd: kempld-core: Correct a variety of checkpatch warnings
  mfd: wm8997-tables: Suppress 'line over 80 chars' warnings

 drivers/mfd/dm355evm_msp.c  |  2 +-
 drivers/mfd/ezx-pcap.c      |  6 +++---
 drivers/mfd/ipaq-micro.c    |  8 ++++----
 drivers/mfd/kempld-core.c   | 10 ++++++----
 drivers/mfd/lp8788-irq.c    |  2 ++
 drivers/mfd/max77686.c      |  2 +-
 drivers/mfd/max8925-core.c  |  2 ++
 drivers/mfd/max8925-i2c.c   |  2 ++
 drivers/mfd/mcp-core.c      |  1 +
 drivers/mfd/sec-core.c      |  1 +
 drivers/mfd/si476x-cmd.c    | 12 ++++++------
 drivers/mfd/tc6387xb.c      |  7 +++----
 drivers/mfd/tps80031.c      |  1 +
 drivers/mfd/twl4030-irq.c   |  6 +++---
 drivers/mfd/twl6030-irq.c   |  4 +++-
 drivers/mfd/twl6040.c       |  2 +-
 drivers/mfd/wm8350-i2c.c    |  8 ++++----
 drivers/mfd/wm8350-irq.c    |  3 ++-
 drivers/mfd/wm8997-tables.c |  8 ++++----
 19 files changed, 50 insertions(+), 37 deletions(-)

-- 
1.8.3.2
