From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Thu,  5 Feb 2015 22:46:56 +0800
Subject: [PATCH 0/4] add usb support for hi6220
Message-ID: <1423147620-5760-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi6220 usb controller is inherited from dwc2
add phy accordingly
support otg gadget/host

Zhangfei Gao (4):
  Documentation: dt-bindings: add dt binding info for hi6220 dwc2
  Documentation: dt-bindings: add dt binding info for hi6220
  usb: dwc2: platform: add hi6220 support
  usb: phy: add phy-hi6220

 Documentation/devicetree/bindings/usb/dwc2.txt     |   1 +
 .../devicetree/bindings/usb/hi6220-usb.txt         |  50 ++++
 drivers/usb/dwc2/platform.c                        |  29 +++
 drivers/usb/phy/Kconfig                            |   8 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-hi6220.c                       | 290 +++++++++++++++++++++
 6 files changed, 379 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hi6220-usb.txt
 create mode 100644 drivers/usb/phy/phy-hi6220.c

-- 
1.9.1
