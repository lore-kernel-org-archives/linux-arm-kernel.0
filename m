From: srinidhikasagar@gmail.com (srinidhi kasagar)
Date: Mon, 7 Sep 2009 16:23:57 +0530
Subject: [PATCH] pl022: fix id for ST vendor
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B11BA7DD366@EXDCVYMBSTM005.EQ1STM.local>
References: <747C1E83C744F44E9ACFB89FAEEC2C7B11BA7DD366@EXDCVYMBSTM005.EQ1STM.local>
Message-ID: <b328b2050909070353iff50c2ar15415bbb4e934ce5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the wrong id being used for ST derivative in PL022 driver.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
---
 drivers/spi/amba-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index da76797..1d51b49 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1828,7 +1828,7 @@ static struct amba_id pl022_ids[] = {
                * ST Micro derivative, this has 32bit wide
                * and 32 locations deep TX/RX FIFO
                */
-               .id     = 0x00108022,
+               .id     = 0x01080022,
               .mask   = 0xffffffff,
               .data   = &vendor_st,
       },
--
1.6.3.GIT
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090907/b1351be0/attachment.htm>
