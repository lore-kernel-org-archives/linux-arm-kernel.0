From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 May 2017 20:50:06 +0200
Subject: [PATCH 0/3] CoreSight-ETB10: Adjustments for three function
 implementations
Message-ID: <5d5cd752-f2f2-b511-6b1e-daf5bf1bc522@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 12 May 2017 20:46:54 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in etb_probe()
  Fix a typo in a comment line
  Improve a size determination in etb_alloc_buffer()

 drivers/hwtracing/coresight/coresight-etb10.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.12.3
