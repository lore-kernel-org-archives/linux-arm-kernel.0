From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 15 Sep 2014 22:24:01 +0200
Subject: [PATCH v2 0/2] mtd: nand: gpmi: add proper raw access support
Message-ID: <1410812643-14041-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Huang, Brian,

This is just a new proposal to support raw accesses in a more standard way
in the GPMI driver.
This series was not tested (just compile tested), and I won't be able to
test it until next week. Thus I don't expect to get it accepted, but
rather to serve as a starting point for our future discussions.

Any suggestions are welcome.

Best Regards,

Boris

Boris BREZILLON (2):
  mtd: nand: gpmi: add gpmi_move_bits function
  mtd: nand: gpmi: add proper raw access support

 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  86 ++++++++++++++++++++++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 118 ++++++++++++++++++++++++++++++++-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |   4 ++
 3 files changed, 207 insertions(+), 1 deletion(-)

-- 
1.9.1
