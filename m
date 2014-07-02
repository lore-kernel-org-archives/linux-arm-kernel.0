From: s-anna@ti.com (Suman Anna)
Date: Wed, 2 Jul 2014 18:00:58 -0500
Subject: [PATCH 0/2] hwspinlock/omap - new SoC support
Message-ID: <1404342060-2919-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

The following two patches allow the OMAP hwspinlock driver
to be enabled for AM33xx, AM437x and DRA7xx SoCs.

The patches are rebased onto 3.16-rc3 and are identical to those
posted in the OMAP hwspinlock DT support v5 series [1][2]. Posting
these separately to decouple from the DT series, as per the discussion
on the lists.

regards
Suman

[1] https://patchwork.kernel.org/patch/4096831/
[2] https://patchwork.kernel.org/patch/4096761/

Suman Anna (2):
  hwspinlock/omap: enable module before reading SYSSTATUS register
  hwspinlock/omap: enable build for AM33xx, AM43xx & DRA7xx

 drivers/hwspinlock/Kconfig           |  2 +-
 drivers/hwspinlock/omap_hwspinlock.c | 27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.0.0
