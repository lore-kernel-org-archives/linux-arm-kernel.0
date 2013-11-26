From: lisovy@gmail.com (Rostislav Lisovy)
Date: Wed, 27 Nov 2013 00:53:14 +0100
Subject: [PATCH 0/2] ARM: i.MX53: voipac-dmm-668 Devicetree
Message-ID: <1385509996-17769-1-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds NAND controller and USB host controller support
for Voipac x53-dmm-668 module.

This patchset applies to linux-next (since the Voipac devicetree
support is not present in any other trees).

Rostislav Lisovy (2):
  ARM: i.MX53: dts: NAND flash controller
  ARM: i.MX53: dts: USB host controller

 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
1.8.3.2
