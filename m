From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 14:52:30 +0100
Subject: [PATCHv3 12/12] MAINTAINERS: add PSCI entry
In-Reply-To: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432648350-5454-13-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself and Lorenzo as maintainers of the PSCI client code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8e0afb..ae3e1c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7789,6 +7789,15 @@ S:	Maintained
 F:	include/linux/power_supply.h
 F:	drivers/power/
 
+POWER STATE COORDINATION INTERFACE (PSCI)
+M:	Mark Rutland <mark.rutland@arm.com>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/psci.c
+F:	include/linux/psci.h
+F:	include/uapi/linux/psci.h
+
 PNP SUPPORT
 M:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 S:	Maintained
-- 
1.9.1
