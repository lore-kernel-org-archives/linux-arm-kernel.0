From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 17:57:53 +0100
Subject: [PATCH v5 5/7] xen/arm: XEN selects ARM_PSCI
In-Reply-To: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
Message-ID: <1366909075-28775-5-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c3bdce..344e299 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1892,6 +1892,7 @@ config XEN
 	depends on ARM && AEABI && OF
 	depends on CPU_V7 && !CPU_V6
 	depends on !GENERIC_ATOMIC64
+	select ARM_PSCI
 	help
 	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
 
-- 
1.7.2.5
