From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 19 Sep 2014 11:04:18 +0800
Subject: [PATCH v3 6/7] arm: dts: Build dtb for mt8127 & mt8135
In-Reply-To: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1411095859-18737-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <1411095859-18737-7-git-send-email-srv_yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

This allows the "make dtbs" to build the moose and mt8135-evbp1
for MediaTek SoC

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 055b20c..1e7380d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -491,7 +491,9 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
-dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb \
+	mt8127-moose.dtb \
+	mt8135-evbp1.dtb
 
 targets += dtbs dtbs_install
 targets += $(dtb-y)
-- 
1.8.1.1.dirty
