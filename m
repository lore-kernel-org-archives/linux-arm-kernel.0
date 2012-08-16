From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 16 Aug 2012 11:08:45 +0800
Subject: [PATCH V3 5/5] arm: mmp: make all SOCs use common clock by default
In-Reply-To: <1345086525-12328-1-git-send-email-xiechao.mail@gmail.com>
References: <1345086525-12328-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1345086525-12328-6-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 7fddd01..d697d07 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -108,18 +108,21 @@ endmenu
 config CPU_PXA168
 	bool
 	select CPU_MOHAWK
+	select COMMON_CLK
 	help
 	  Select code specific to PXA168
 
 config CPU_PXA910
 	bool
 	select CPU_MOHAWK
+	select COMMON_CLK
 	help
 	  Select code specific to PXA910
 
 config CPU_MMP2
 	bool
 	select CPU_PJ4
+	select COMMON_CLK
 	help
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
 
-- 
1.7.0.4
