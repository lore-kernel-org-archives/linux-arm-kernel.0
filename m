From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  5 May 2014 17:05:24 +0200
Subject: [PATCH v2 3/5] ARM: mvebu: add Armada 375 A0 revision definition
In-Reply-To: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399302326-6917-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399302326-6917-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have access to Armada 375 A0 platforms, we can add the
corresponding revision definition in mvebu-soc-id.h.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/mvebu-soc-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index 294a443..c16bb68 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -22,6 +22,7 @@
 
 /* Armada 375 */
 #define ARMADA_375_Z1_REV   0x0
+#define ARMADA_375_A0_REV   0x3
 
 #ifdef CONFIG_ARCH_MVEBU
 int mvebu_get_soc_id(u32 *dev, u32 *rev);
-- 
1.9.2
