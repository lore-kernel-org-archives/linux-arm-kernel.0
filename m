From: nm@ti.com (Nishanth Menon)
Date: Thu, 6 Feb 2014 09:29:31 -0600
Subject: [PATCH] ARM: multi_v7_defconfig: Select CONFIG_SOC_DRA7XX
Message-ID: <1391700571-31784-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_SOC_DRA7XX so that we can boot dra7-evm.
DRA7 family are A15 based processors that supports LPAE and an
evolutionary update to the OMAP5 generation of processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

based on v3.13-rc1 kernel tag - tested on v3.14-rc1 and next-20140206

 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 845bc74..ee69829 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
+CONFIG_SOC_DRA7XX=y
 CONFIG_SOC_AM43XX=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SOCFPGA=y
-- 
1.7.9.5
