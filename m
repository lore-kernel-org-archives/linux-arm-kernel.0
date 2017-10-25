From: elder@linaro.org (Alex Elder)
Date: Wed, 25 Oct 2017 16:53:33 -0500
Subject: [PATCH 2/3] arm64: defconfig: remove CONFIG_USB_MSM_OTG
In-Reply-To: <20171025215334.19004-1-elder@linaro.org>
References: <20171025215334.19004-1-elder@linaro.org>
Message-ID: <20171025215334.19004-3-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No Qualcomm SoC requires the "phy-msm-usb.c" USB phy driver support
any more.  Remove the code, and remove the config option from the
arm64 defconfig.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Alex Elder <elder@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d0b96bb340a..85ca53f59c3e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -425,7 +425,6 @@ CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
-CONFIG_USB_MSM_OTG=y
 CONFIG_USB_QCOM_8X16_PHY=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
-- 
2.11.0
