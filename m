From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 14:12:46 +0530
Subject: [PATCH 0/3] miscellaneous fixes in coresight
Message-ID: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some typo and minor issues in coresight which 
I observed while going through this driver.

Pankaj Dubey (3):
  coresight: fix typo in comment in coresight-priv.h
  coresight: fixed comments in coresight.h
  coresight-replicator: remove .owner field for driver

 drivers/coresight/coresight-priv.h       |    2 +-
 drivers/coresight/coresight-replicator.c |    1 -
 include/linux/coresight.h                |    6 +++---
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
1.7.9.5
