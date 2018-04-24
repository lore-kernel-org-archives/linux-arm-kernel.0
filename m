From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 24 Apr 2018 11:41:45 +0200
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: enable STM32 USB PHY
 Controller (USBPHYC)
In-Reply-To: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
References: <1524562905-19361-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524562905-19361-5-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the STM32 USB PHY Controller (USBPHYC) driver, implemented on
STM32MP1 SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e6b3c96..e78b43f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -972,6 +972,7 @@ CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_STIH407_USB=y
+CONFIG_PHY_STM32_USBPHYC=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
-- 
2.7.4
