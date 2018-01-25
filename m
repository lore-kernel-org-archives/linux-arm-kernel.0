From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 25 Jan 2018 16:45:12 +0100
Subject: [PATCH 0/2] Input: sirfsoc-onkey: Adjustments for sirfsoc_pwrc_probe()
Message-ID: <b66f4105-57f2-adc2-ecde-cd4dacac408c@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 16:42:24 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/input/misc/sirfsoc-onkey.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.16.1
