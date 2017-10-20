From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 20 Oct 2017 17:15:08 +0200
Subject: [PATCH 0/2] ARM-OMAP3: Fine-tuning for omap3xxx_hwmod_init()
Message-ID: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 17:08:09 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Delete an unnecessary variable initialisation

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.14.2
