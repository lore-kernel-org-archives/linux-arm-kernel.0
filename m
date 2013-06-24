From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jun 2013 18:31:26 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for ARM system MMU driver
In-Reply-To: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
Message-ID: <1372095086-15681-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer for the ARM system MMU driver.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5be702c..1eb2a72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,12 @@ T:	git git://git.xilinx.com/linux-xlnx.git
 S:	Supported
 F:	arch/arm/mach-zynq/
 
+ARM SMMU DRIVER
+M:	Will Deacon <will.deacon@arm.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/iommu/arm-smmu.c
+
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
 M:	Will Deacon <will.deacon@arm.com>
-- 
1.8.2.2
