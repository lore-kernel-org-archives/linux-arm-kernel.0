From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  2 Jul 2014 16:28:32 +0100
Subject: [PATCH 01/12] mfd: Bunch of clean-ups and checkpatch fixes 
Message-ID: <1404314924-23564-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set contains a bunch of cleanups for issues that were
either noticed during recent patch submission review or that
checkpatch spotted.

 drivers/mfd/88pm805.c             |  2 +-
 drivers/mfd/88pm860x-core.c       | 37 +++++++++++++++++++------------
 drivers/mfd/88pm860x-i2c.c        |  3 ++-
 drivers/mfd/aat2870-core.c        |  5 ++++-
 drivers/mfd/ab3100-core.c         | 54 ++++++++++++++++++--------------------
 drivers/mfd/ab8500-core.c         | 49 ++++++++++++++++++-------------------
 drivers/mfd/ab8500-debugfs.c      | 14 ++++++------
 drivers/mfd/arizona-core.c        |  4 ++--
 drivers/mfd/arizona-i2c.c         |  5 +++--
 drivers/mfd/arizona-spi.c         |  3 ++-
 drivers/mfd/arizona.h             |  4 ++--
 drivers/mfd/intel_soc_pmic_core.c |  2 ++
 drivers/mfd/stmpe-i2c.c           |  4 ++--
 drivers/mfd/stmpe.c               |  2 +-
 drivers/mfd/stmpe.h               |  2 +-
 drivers/mfd/tps65910.c            | 10 +++++-----
 include/linux/mfd/tps65910.h      |  2 +-
 17 files changed, 109 insertions(+), 93 deletions(-)
