From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat,  2 Apr 2016 18:25:51 +0200
Subject: [PATCH v3 9/9] ARM: imx_v6_v7_defconfig: add CONFIG_RTC_DRV_M41T80
In-Reply-To: <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1459614351-16731-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1459614351-16731-10-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rv4168 RTC is used by the following platforms:
- Nitrogen6_MAX (both Quad and Quad Plus versions)
- Nitrogen7

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---

Changes v1 -> v2:
- none
Changes v2 -> v3:
- none

---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 1faafe3..af22ea4 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -316,6 +316,7 @@ CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_ISL1208=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_PCF8563=y
+CONFIG_RTC_DRV_M41T80=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_SNVS=y
-- 
2.7.0
