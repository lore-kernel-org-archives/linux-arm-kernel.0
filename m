From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 27 Oct 2017 17:11:27 +0100
Subject: [PATCH v10 9/9] MANTAINERS: Add maintainer for HiSilicon LPC driver
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <1509120687-7352-10-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488d..b49d4c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6130,6 +6130,13 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON LPC BUS DRIVER
+L:	linuxarm at huawei.com
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
