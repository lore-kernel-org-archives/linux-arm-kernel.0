From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:23 +0100
Subject: [PATCHv2 12/12] MAINTAINERS: add PSCI entry
In-Reply-To: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431945503-6939-13-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself and Lorenzo as maintainers of the PSCI client code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 590304b..1694148 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7770,6 +7770,15 @@ S:	Maintained
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
