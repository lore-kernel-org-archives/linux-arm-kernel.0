From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:45 +0100
Subject: [PATCH 9/9] MAINTAINERS: add entry for ARM system MMU driver
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer for the ARM system MMU driver.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250dc97..84df4bd 100644
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
