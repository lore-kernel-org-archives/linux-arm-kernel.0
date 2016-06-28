From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:23 -0400
Subject: [PATCH 2/8] arm64:MAINTAINERS:hisi: Add hisilicon SoC PMU support
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-3-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Add support for Hisilicon SoC hardware event counters.
	Support ARM64 architecture.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c51c736..cf7dc0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5405,6 +5405,14 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON PMU DRIVER
+M:	Anurup M <anurup.m@huawei.com>
+M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
+W:	http://www.hisilicon.com
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
+F:	drivers/perf/hisilicon/*
+
 HISILICON SAS Controller
 M:	John Garry <john.garry@huawei.com>
 W:	http://www.hisilicon.com
-- 
2.1.4
