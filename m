From: joe@perches.com (Joe Perches)
Date: Tue, 08 Dec 2009 10:21:55 -0800
Subject: Missing ARM/BCMRING MTD NAND DRIVER files?
Message-ID: <1260296515.27677.45.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 57a473f2f97cf3bca78df08aac2f438ddef03bee added
this MAINTAINERS entry, but not the files listed.

No other commit added these files either.

Are these files supposed to be part of kernel sources?
If not, I think the MAINTAINERS entry should be removed.

ARM/BCMRING MTD NAND DRIVER
M:	Leo Chen <leochen@broadcom.com>
M:	Scott Branden <sbranden@broadcom.com>
L:	linux-mtd at lists.infradead.org
S:	Maintained
F:	drivers/mtd/nand/bcm_umi_nand.c
F:	drivers/mtd/nand/bcm_umi_bch.c
F:	drivers/mtd/nand/bcm_umi_hamming.c
F:	drivers/mtd/nand/nand_bcm_umi.h
