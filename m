From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Dec 2016 17:57:53 +0100
Subject: [PATCH 0/2] ARM: mmp: Fine-tuning for sram_probe()
Message-ID: <b687577b-e664-6aa1-a85c-438e96216171@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Dec 2016 17:50:23 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Check return values from ioremap() and kstrdup()
  Delete an unnecessary variable initialisation

 arch/arm/mach-mmp/sram.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.11.0
