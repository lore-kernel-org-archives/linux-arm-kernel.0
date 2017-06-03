From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 22:07:49 +0200
Subject: [PATCH 0/3] ARM-pxa: Adjustments for two function implementations
Message-ID: <f50bf224-7fdc-f9ba-b73b-0b3c11df50dc@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 22:02:34 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation in pxa_pm_init()
  Improve a size determination in pxa3xx_u2d_probe()
  Delete an error message for a failed memory allocation in pxa3xx_u2d_probe()

 arch/arm/mach-pxa/pm.c          | 4 +---
 arch/arm/mach-pxa/pxa3xx-ulpi.c | 6 ++----
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.13.0
