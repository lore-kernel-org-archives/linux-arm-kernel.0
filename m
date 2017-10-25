From: elder@linaro.org (Alex Elder)
Date: Wed, 25 Oct 2017 16:53:31 -0500
Subject: [PATCH 0/3] arm64: defconfig: remove some Qualcomm USB options
Message-ID: <20171025215334.19004-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series deletes three config options related to USB on Qualcomm
SoCs from the arm64 "defconfig".  The code enabled by the options is
no longer needed by any Qualcomm hardware.  

					-Alex

Alex Elder (3):
  arm64: defconfig: remove CONFIG_USB_EHCI_MSM
  arm64: defconfig: remove CONFIG_USB_MSM_OTG
  arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

 arch/arm64/configs/defconfig | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.11.0
