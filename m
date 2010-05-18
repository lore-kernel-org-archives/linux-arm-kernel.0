From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 20:47:15 +0900
Subject: [PATCH v2 2/9] ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
Message-ID: <007c01caf67f$e096f730$a1c4e590$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch has been merged into Ben Dooks' tree, for-2635/s3c64xx-ts.
So need to rebase this commit.

(http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/014148.html)
---
commit 34b01740be6e010976a2f5aa8f343d3b5dd6d278
Author: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date:   Tue May 4 13:12:41 2010 +0200

    ARM: SAMSUNG: Move mach/ts.h to plat/ts.h

    This moves mach-s3c2410/include/mach/ts.h to
plat-samsung/include/plat/ts.h in
    order to prepare for s3c64xx support in the touchscreen driver.

    Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
    Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
