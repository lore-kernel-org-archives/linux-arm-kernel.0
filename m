From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 16 Sep 2015 09:46:35 +0200
Subject: [PATCH 0/2] mtd: nand: sunxi: cleanup
Message-ID: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Those two patches aim at cleaning up the sunxi_nand driver by first adding
some consistency in the macro definitions, and then factorizing the code
duplicated code found in hw_ecc and hw_syndrome_ecc implementations.

Best Regards,

Boris

Boris Brezillon (2):
  mtd: nand: sunxi: rework macros
  mtd: sunxi: nand: refactor ->read_page()/->write_page() code

 drivers/mtd/nand/sunxi_nand.c | 487 ++++++++++++++++++++++--------------------
 1 file changed, 256 insertions(+), 231 deletions(-)

-- 
1.9.1
