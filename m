From: elder@linaro.org (Alex Elder)
Date: Thu, 26 Oct 2017 08:48:24 -0500
Subject: [PATCH v2 0/3] usb: remove some unused code
Message-ID: <20171026134827.615-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series deletes some Qualcomm USB code is no longer needed by
any Qualcomm hardware.  This version properly deletes the sections
of Kconfig files that control whether the deleted code gets built.
(This time I'm also sending to linux-arm-msm and linux-arm-kernel.)

					-Alex
Alex Elder (3):
  usb: host: remove ehci-msm.c
  usb: phy: remove phy-msm-usb.c
  usb: phy: remove phy-qcom-8x16-usb.c

 drivers/usb/host/Makefile           |    1 -
 drivers/usb/host/ehci-msm.c         |  265 -----
 drivers/usb/phy/Makefile            |    2 -
 drivers/usb/phy/phy-msm-usb.c       | 2085 -----------------------------------
 drivers/usb/phy/phy-qcom-8x16-usb.c |  366 ------
 5 files changed, 2719 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-msm.c
 delete mode 100644 drivers/usb/phy/phy-msm-usb.c
 delete mode 100644 drivers/usb/phy/phy-qcom-8x16-usb.c

-- 
2.11.0
