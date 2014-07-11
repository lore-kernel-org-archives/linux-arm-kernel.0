From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 11 Jul 2014 16:36:35 -0400
Subject: [PATCH v4 6/6] PCI: keystone: Update maintainer information
In-Reply-To: <1405110995-24676-1-git-send-email-m-karicheri2@ti.com>
References: <1405110995-24676-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1405110995-24676-7-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the MAINTAINERS file for the keystone PCIe driver

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

CC: Russell King <linux@arm.linux.org.uk>
CC: Grant Likely <grant.likely@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mohit Kumar <mohit.kumar@st.com>
CC: Jingoo Han <jg1.han@samsung.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Pratyush Anand <pratyush.anand@st.com>
CC: Richard Zhu <r65037@freescale.com>
CC: Kishon Vijay Abraham I <kishon@ti.com>
CC: Marek Vasut <marex@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Randy Dunlap <rdunlap@infradead.org>
CC: Grant Likely <grant.likely@linaro.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c411c40..0a17971 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6793,6 +6793,13 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/pci/host/*imx6*
 
+PCI DRIVER FOR keystone
+M:	Murali Karicheri <m-karicheri2@ti.com>
+L:	linux-pci at vger.kernel.org
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/pci/host/*keystone*
+
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 M:	Jason Cooper <jason@lakedaemon.net>
-- 
1.7.9.5
