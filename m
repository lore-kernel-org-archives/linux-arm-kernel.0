From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 6 Feb 2013 20:26:36 +0530
Subject: [PATCH 0/8] ARM: dts: omap: Add dts data for USB
Message-ID: <1360162604-14320-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

Here are the dt data patches to get usb device functional in OMAP platforms.
This series applies cleanly in both for_3.9/dts and 3.8-rc6.

All the patches deal with modifying arch/arm/boot except one which modifies
Documentation/../usb/omap-usb.txt

Kishon Vijay Abraham I (8):
  ARM: dts: omap: Add omap control usb data
  ARM: dts: omap: Add omap-usb2 dt data
  ARM: dts: omap: Add usb_otg and glue data
  ARM: dts: omap5: Add omap control usb data
  ARM: dts: omap5: Add ocp2scp data
  ARM: dts: omap5: Add omap-usb3 and omap-usb2 dt data
  ARM: dts: omap5: add dwc3 omap dt data
  ARM: dts: omap5: add dwc3 core dt data

 Documentation/devicetree/bindings/usb/omap-usb.txt |    1 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    6 +++
 arch/arm/boot/dts/omap3-evm.dts                    |    6 +++
 arch/arm/boot/dts/omap3-overo.dtsi                 |    6 +++
 arch/arm/boot/dts/omap3.dtsi                       |   12 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |    6 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |    6 +++
 arch/arm/boot/dts/omap4.dtsi                       |   26 +++++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   48 ++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi                     |    2 +-
 10 files changed, 118 insertions(+), 1 deletion(-)

-- 
1.7.10.4
