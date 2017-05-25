From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 25 May 2017 12:37:28 +0100
Subject: [PATCH v9 7/7] MANTAINERS: Add maintainer for HiSilicon LPC driver
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <1495712248-5232-8-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e98464..8fb9006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6061,6 +6061,14 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON LPC BUS DRIVER
+M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
+L:	linux-arm-kernel at lists.infradead.org
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
2.7.4
