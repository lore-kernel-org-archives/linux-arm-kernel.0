From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Fri, 16 Nov 2018 11:14:09 +0000
Subject: [PATCH v5 4/5] arm64: defconfig: enable NXP FlexSPI driver
In-Reply-To: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1542366701-16065-5-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d1..3d81e25 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -341,6 +341,7 @@ CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
-- 
2.7.4
