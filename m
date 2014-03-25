From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 24 Mar 2014 20:33:22 -0400
Subject: [PATCH 1/3] ARM: keystone: add pcie related options
In-Reply-To: <1395707604-20377-1-git-send-email-m-karicheri2@ti.com>
References: <1395707604-20377-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1395707604-20377-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pcie related options by default for keystone architecture

CC: Jingoo Han <jg1.han@samsung.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Kukjin Kim <kgene.kim@samsung.com>
CC: Richard Zhu <r65037@freescale.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Mohit Kumar <mohit.kumar@st.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/mach-keystone/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 7e16d07..22c2174 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -17,6 +17,8 @@ config ARCH_KEYSTONE
 	select TI_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ZONE_DMA if ARM_LPAE
+	select MIGHT_HAVE_PCI
+	select ARCH_SUPPORTS_MSI
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
