From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Mon, 27 Jun 2016 17:54:07 +0800
Subject: [PATCH net-next 1/9] MAINTAINERS: add maintainers for hns driver
In-Reply-To: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1467021255-95900-2-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daode Huang <huangdaode@hisilicon.com>

This patch adds maintainers for hisilicon network subsystem driver

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a171a9..c819659 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5421,6 +5421,15 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON NETWORK SUBSYSTEM DRIVER
+M:	Yisen Zhuang <yisen.zhuang@huawei.com>
+M:	Salil Mehta <salil.mehta@huawei.com>
+L:	netdev at vger.kernel.org
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/net/ethernet/hisilicon/*
+F:	Documentation/devicetree/bindings/net/hisilicon*.txt
+
 HISILICON SAS Controller
 M:	John Garry <john.garry@huawei.com>
 W:	http://www.hisilicon.com
-- 
1.9.1
