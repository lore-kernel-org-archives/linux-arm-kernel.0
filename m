From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:34 +0530
Subject: [PATCH V2 14/69] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <9f49c2ec5155f890066d32ab680e99738325d312.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/include/mach/spear320.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index cacf17a..53677e4 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -62,7 +62,7 @@
 #define SPEAR320_SMII1_BASE		0xAB000000
 #define SPEAR320_SMII1_SIZE		0x01000000
 
-#define SPEAR320_SOC_CONFIG_BASE	0xB4000000
+#define SPEAR320_SOC_CONFIG_BASE	0xB3000000
 #define SPEAR320_SOC_CONFIG_SIZE	0x00000070
 /* Interrupt registers offsets and masks */
 #define INT_STS_MASK_REG		0x04
-- 
1.7.2.2
