From: elder@linaro.org (Alex Elder)
Date: Tue, 31 Oct 2017 07:58:05 -0500
Subject: [PATCH v2 0/3] arm64: defconfig: remove some Qualcomm USB options
Message-ID: <20171031125808.7300-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series deletes three config options related to USB on Qualcomm
SoCs from the arm64 "defconfig".  The code enabled by the options is
no longer needed by any Qualcomm hardware.  The driver code that
corresponds to these config options is removed in a separate series.

					-Alex

v2:  Added Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

Alex Elder (3):
  arm64: defconfig: remove CONFIG_USB_EHCI_MSM
  arm64: defconfig: remove CONFIG_USB_MSM_OTG
  arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.11.0
