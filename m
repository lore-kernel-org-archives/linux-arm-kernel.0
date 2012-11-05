From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  5 Nov 2012 16:10:28 +0100
Subject: [PATCH 0/8] mfd: Batch together MFD related patches
Message-ID: <1352128236-11554-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sam,

I know you've been busy giving NFC presentations at ELC, but ... :)

All these patches have been on the list in various other patch-sets
for some time and have been reviewed by some key people already. All
other patches from the patch-sets have been taken, so I thought I'd
batch these up for easy review/acceptance.

 Documentation/devicetree/bindings/mfd/stmpe.txt |   25 ++++
 drivers/mfd/ab8500-core.c                       |   98 ++++-----------
 drivers/mfd/db8500-prcmu.c                      |    8 +-
 drivers/mfd/stmpe.c                             |  151 ++++++++++++++++-------
 include/linux/mfd/stmpe.h                       |    2 +
 5 files changed, 160 insertions(+), 124 deletions(-)
