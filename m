From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 14 Jul 2016 01:53:18 +0800
Subject: [PATCH v7 5/9] MAINTAINERS / ACPI: add the ARM64-specific ACPI
 Support maintainers
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1468432402-4872-6-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch add the ARM64-specific ACPI Support maintainers in
MAINTAINERS, according to the discussion on mailing list:
https://lkml.org/lkml/2016/6/29/580
Lorenzo Pieralisi will submit the pull requsts.

The maintainers are listed by the alphabet order of
their name.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1209323..1e03463 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,14 @@ W:	https://01.org/linux-acpi
 S:	Supported
 F:	drivers/acpi/fan.c
 
+ACPI FOR ARM64 (ACPI/arm64)
+M:	Hanjun Guo <hanjun.guo@linaro.org>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-acpi at vger.kernel.org
+S:	Supported
+F:	drivers/acpi/arm64
+
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi at vger.kernel.org
-- 
2.5.5
