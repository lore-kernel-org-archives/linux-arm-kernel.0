From: zonque@gmail.com (Daniel Mack)
Date: Mon,  7 Nov 2011 16:43:27 +0100
Subject: [PATCH 0/4] Re-sending pxa3xx nand controller patches
Message-ID: <1320680611-29448-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These four patches have been discussed in June this year and at least
two of them are mandatory for the pxa3xx driver to operate. I'm not 
aware of any reason why they didn't make it to any repository, but
most probably they were just forgotten.

Axel Lin (2):
  mtd: pxa3xx_nand: fix a memory leak
  mtd: pxa3xx_nand: remove unused variable 'mtd'

Daniel Mack (1):
  mtd: pxa3xx_nand: Fix blank page ECC mismatch

Lei Wen (1):
  mtd: pxa3xx_nand: fix nand detection issue

 drivers/mtd/nand/pxa3xx_nand.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.7.6.4
