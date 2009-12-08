From: sbranden@broadcom.com (Scott Branden)
Date: Tue, 8 Dec 2009 10:25:46 -0800
Subject: Missing ARM/BCMRING MTD NAND DRIVER files?
In-Reply-To: <1260296515.27677.45.camel@Joe-Laptop.home>
References: <1260296515.27677.45.camel@Joe-Laptop.home>
Message-ID: <9383297B60843144AC17878B479520F110B62DF365@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They have been sitting in David Woodhouse's GIT tree.
They are already in linux-next. and should have made it
 in 2.6.32 put did not get pulled.
Just waiting a pull from Linus in 2.6.33. 

Cheers,
 Scott

-----Original Message-----
From: Joe Perches [mailto:joe at perches.com] 
Sent: December 8, 2009 10:22 AM
To: Leo (Hao) Chen; Scott Branden; linux-mtd
Cc: linux-arm-kernel at lists.infradead.org
Subject: Missing ARM/BCMRING MTD NAND DRIVER files?

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
