From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 17 Sep 2014 15:10:02 +0300
Subject: [PATCH v2 0/6] ARM: dts: cm-t54: enable video out,
 touchscreen and USB3.0
In-Reply-To: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CM-T54 DT nodes:

* enable HDMI/DVI/LCD video output support
* add ADS7846 touchscreen support
* enchance DWC3 setup to enable power supply for USB3.0 OTG port

v2: * Fixed comment style issue for mux mode.
      Follow the convention mode0_name.modeX_name for pins
      which mux mode differs from MUX_MODE0

    * Moved aliases node to the top of dts file

Dmitry Lifshitz (6):
  ARM: dts: sbc-t54: fix mux mode comment style
  ARM: dts: cm-t54: fix mux mode comment style
  ARM: dts: cm-t54: add HDMI/DVI display data
  ARM: dts: cm-t54: add Startek LCD support
  ARM: dts: cm-t54: add ADS7846 touchscreen support
  ARM: dts: cm-t54: setup omap_dwc3

 arch/arm/boot/dts/omap5-cm-t54.dts  |  272 ++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 +-
 2 files changed, 272 insertions(+), 4 deletions(-)

-- 
1.7.5.4
