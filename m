From: tbm@cyrius.com (Martin Michlmayr)
Date: Wed, 11 Nov 2009 15:32:23 +0000
Subject: drivers/mtd/nand/orion_nand.c build failure with old ABI
Message-ID: <20091111153223.GA3688@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mtd/nand/orion_nand.c fails to build when EABI is not set:

  CC      drivers/mtd/nand/orion_nand.o
/tmp/ccDFyfwN.s: Assembler messages:
/tmp/ccDFyfwN.s:120: Error: first destination register must be even -- `ldrd r3,[ip]'
make[3]: *** [drivers/mtd/nand/orion_nand.o] Error 1
make[2]: *** [drivers/mtd/nand] Error 2

-- 
Martin Michlmayr
http://www.cyrius.com/
