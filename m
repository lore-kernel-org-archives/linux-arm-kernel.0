From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  6 Jan 2014 12:15:49 -0700
Subject: [PATCH] ARM: tegra: document which Dalmore revisions are supported
Message-ID: <1389035749-15261-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

There are a number of revisions of the Dalmore board, each with a variety
of incompatible SW-visible HW changes. The Dalmore DT file in the kernel
only supports HW revision A04. Document this in the DT file.

Reported-by: Paul Walmsley <pwalmsley@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 73aecfb57ccb..8de543777882 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1,3 +1,8 @@
+/*
+ * This dts file supports Dalmore A04.
+ * Other board revisions are not supported
+ */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
-- 
1.8.1.5
