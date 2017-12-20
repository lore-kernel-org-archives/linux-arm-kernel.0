From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 20 Dec 2017 10:50:13 +0100
Subject: [PATCH 0/2] pinctrl/nomadik/abx500: Adjustments for
 abx500_gpio_probe()
Message-ID: <e5be1da7-460d-a47d-59b8-c1902907f5a4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 20 Dec 2017 10:45:01 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete an error message for a failed memory allocation
  Improve a size determination

 drivers/pinctrl/nomadik/pinctrl-abx500.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

-- 
2.15.1
