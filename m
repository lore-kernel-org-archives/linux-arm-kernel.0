From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 18 Jan 2011 12:41:42 +0530
Subject: [PATCH V4 14/62] ST SPEAr: Correcting SOC Config base address for
	spear320
In-Reply-To: <cover.1295333957.git.viresh.kumar@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
Message-ID: <12d6715aee0d9ec908feeb7b37f4ca94e95d42a1.1295333958.git.viresh.kumar@st.com>
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
