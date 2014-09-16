From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 16 Sep 2014 19:35:18 +0300
Subject: [PATCH 0/4] ARM: dts: cm-t54: enable video out, touchscreen and USB3.0
Message-ID: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CM-T54 DT nodes:

* enable HDMI/DVI/LCD video output support
* add ADS7846 touchscreen support
* enchance DWC3 setup to enable power supply for USB3.0 OTG port

Dmitry Lifshitz (4):
  ARM: dts: cm-t54: add HDMI/DVI display data
  ARM: dts: cm-t54: add Startek LCD support
  ARM: dts: cm-t54: add ADS7846 touchscreen support
  ARM: dts: cm-t54: setup omap_dwc3

 arch/arm/boot/dts/omap5-cm-t54.dts |  268 ++++++++++++++++++++++++++++++++++++
 1 files changed, 268 insertions(+), 0 deletions(-)

-- 
1.7.5.4
