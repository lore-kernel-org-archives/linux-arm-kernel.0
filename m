From: ioana.ciornei@nxp.com (Ioana Ciornei)
Date: Mon, 5 Nov 2018 09:30:32 +0000
Subject: [PATCH 0/2] soc: fsl: dpio: cleanup on the remove path
Message-ID: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the remove path in the dpio driver so that
successive bind/unbind commands behave properly.

Ioana Ciornei (2):
  soc: fsl: dpio: cleanup the cpu array on dpaa2_io_down
  soc: fsl: dpio: use a cpumask to identify which cpus are unused

 drivers/soc/fsl/dpio/dpio-driver.c  | 25 ++++++++++++++++---------
 drivers/soc/fsl/dpio/dpio-service.c | 11 +++++++++++
 include/soc/fsl/dpaa2-io.h          |  2 ++
 3 files changed, 29 insertions(+), 9 deletions(-)

-- 
1.9.1
