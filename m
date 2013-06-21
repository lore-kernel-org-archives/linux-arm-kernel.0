From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 21 Jun 2013 11:39:35 +0100
Subject: [PATCH v4 5/7] ARM:stixxxx: Add stixxxx options to multi_v7_defconfig
In-Reply-To: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
References: <1371811076-27168-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1371811175-27409-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds stih415 and stih416 support to multi_v7_defconfig.
CONFIG_ARM_ERRATA_754322 is removed as it is selected by the stixxxx
mach level kconfig.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/configs/multi_v7_defconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f2b4957..c0cfac0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -9,11 +9,11 @@ CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
+CONFIG_ARCH_STIXXXX=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_SIRF=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
-CONFIG_ARM_ERRATA_754322=y
 CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
@@ -43,6 +43,8 @@ CONFIG_SERIAL_SIRFSOC_CONSOLE=y
 CONFIG_SERIAL_VT8500=y
 CONFIG_SERIAL_VT8500_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_ST_ASC=y
+CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_SI=y
 CONFIG_I2C=y
-- 
1.7.6.5
