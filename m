From: zonque@gmail.com (Daniel Mack)
Date: Mon, 07 Nov 2011 12:27:00 +0100
Subject: Missing patches for pxa3xx_nand
Message-ID: <4EB7C084.4060706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In June, there have been important patches submitted for the pxa3xx_nand 
driver after it was broken by Lei's rework series. These patches were 
discussed in June, and they are present in

   git://git.infradead.org/mtd-2.6.git linux-fallback

but not in the master branch of the same git. Also, they have not been 
merged to Linus' master tree which renders the pxa3xx_nand driver 
unusable in 3.0 and 3.1.

A selection of the patches I'm talking about are titled

   mtd: pxa3xx_nand: Fix blank page ECC mismatch
   mtd: pxa3xx_nand: fix nand detection issue
   mtd: pxa3xx_nand don't specify default parsing options

and of course they depend on others that aren't merged yet either.

Can anyone explain what went wrong here and how we can get out of this?


Thanks,
Daniel
