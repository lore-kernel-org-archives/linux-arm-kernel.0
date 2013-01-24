From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 24 Jan 2013 13:33:25 -0600
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: add ARCH_ZYNQ
In-Reply-To: <bb37ce3392153c4cae3a2bc642f831683620473a.1359057921.git.josh.cartwright@ni.com>
References: <bb37ce3392153c4cae3a2bc642f831683620473a.1359057921.git.josh.cartwright@ni.com>
Message-ID: <621fb4946273492b88fe9a903118047f497e00ee.1359057921.git.josh.cartwright@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Michal Simek <michal.simek@ni.com>
Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6862e76..e31d442 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -8,6 +8,7 @@ CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_ARCH_SUNXI=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
+CONFIG_ARCH_ZYNQ=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_SMP=y
 CONFIG_ARM_ARCH_TIMER=y
-- 
1.8.1.1
