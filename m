From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 20 Dec 2010 13:55:35 +0530
Subject: [PATCH V3 14/63] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <cover.1292833228.git.viresh.kumar@st.com>
References: <cover.1292833228.git.viresh.kumar@st.com>
Message-ID: <b03a87f37c99b340fae7a3fdfac2dfdab2a3bf71.1292833228.git.viresh.kumar@st.com>
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
