From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:06 -0600
Subject: [PATCH V2 01/12] MAINTAINERS: Adding Maintainers for AMD Seattle
 Device Tree
In-Reply-To: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1454954357-8395-2-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Adding maintainers for AMD Seattle device tree.

Signed-off-by: Brijesh Singh <brijeshkumar.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f1fa4f..e349a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -673,6 +673,13 @@ F:	drivers/gpu/drm/radeon/radeon_kfd.c
 F:	drivers/gpu/drm/radeon/radeon_kfd.h
 F:	include/uapi/linux/kfd_ioctl.h
 
+AMD SEATTLE DEVICE TREE SUPPORT
+M:	Brijesh Singh <brijeshkumar.singh@amd.com>
+M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+M:	Tom Lendacky <thomas.lendacky@amd.com>
+S:	Supported
+F:	arch/arm64/boot/dts/amd/
+
 AMD XGBE DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 L:	netdev at vger.kernel.org
-- 
2.5.0
