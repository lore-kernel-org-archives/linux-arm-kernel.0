From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 15 Sep 2017 19:27:03 +0200
Subject: [PATCH 0/2] [media] STM32-DCMI: Adjustments for three function
 implementations
Message-ID: <730b535e-39a5-2c2b-f463-e76da967a723@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Sep 2017 19:01:23 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation in two functions
  Improve four size determinations

 drivers/media/platform/stm32/stm32-dcmi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
2.14.1
