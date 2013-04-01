From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:19 -0500
Subject: [PATCH v2 09/13] ARM: versatile: add versatile dtbs to dtbs target
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add the versatile platform dtbs to the dtbs make rule.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..08d298d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -165,6 +165,8 @@ dtb-$(CONFIG_ARCH_TEGRA) += tegra20-harmony.dtb \
 	tegra30-cardhu-a04.dtb \
 	tegra114-dalmore.dtb \
 	tegra114-pluto.dtb
+dtb-$(CONFIG_ARCH_VERSATILE) += versatile-ab.dtb \
+	versatile-pb.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += vexpress-v2p-ca5s.dtb \
 	vexpress-v2p-ca9.dtb \
 	vexpress-v2p-ca15-tc1.dtb \
-- 
1.7.10.4
