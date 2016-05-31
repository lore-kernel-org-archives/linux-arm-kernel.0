From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 31 May 2016 12:57:33 +0100
Subject: [PATCH 0/5] coresight: Miscellaneous fixes
Message-ID: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a collection fixes / cleanups for the coresight driver.

Patches 1,2 are proper fixes and would be good to have it fixed for 4.7.
Patches 3-5 are cleanups.

Suzuki K Poulose (5):
  coresight: Fix NULL pointer dereference in _coresight_build_path
  coresight: etmv4: Fix ETMv4x peripheral ID table
  coresight: Fix csdev connections initialisation
  coresight: Add better messages for coresight_timeout
  coresight: Cleanup TMC status check

 drivers/hwtracing/coresight/coresight-etb10.c   |  6 ++--
 drivers/hwtracing/coresight/coresight-etm4x.c   | 14 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c     |  6 ++--
 drivers/hwtracing/coresight/coresight.c         | 48 ++++++++++++++-----------
 5 files changed, 38 insertions(+), 38 deletions(-)

-- 
1.9.1
