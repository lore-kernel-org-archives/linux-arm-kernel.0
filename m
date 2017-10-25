From: elder@linaro.org (Alex Elder)
Date: Wed, 25 Oct 2017 16:53:32 -0500
Subject: [PATCH 1/3] arm64: defconfig: remove CONFIG_USB_EHCI_MSM
In-Reply-To: <20171025215334.19004-1-elder@linaro.org>
References: <20171025215334.19004-1-elder@linaro.org>
Message-ID: <20171025215334.19004-2-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No Qualcomm SoC requires the "ehci-msm.c" code any more.  So remove
the code, and remove the config option from the arm64 defconfig.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Alex Elder <elder@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..4d0b96bb340a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -410,7 +410,6 @@ CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MSM=y
 CONFIG_USB_EHCI_EXYNOS=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.11.0
