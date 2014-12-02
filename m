From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Tue,  2 Dec 2014 15:37:15 -0700
Subject: [PATCH 0/3 RESEND] ARM: dts: sabrelite I2C and HDMI additions
Message-ID: <1417559839-17365-1-git-send-email-eric.nelson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches adds support for I2C2/3 busses and HDMI output
for the SABRE Lite board.

The content was gratuitously copied from the following commits
for the Nitrogen6X board made by Lucas Stach, Michael Olbrich, 
and Philipp Zabel at Pengutronix:

	43c3c00 - ARM: dts: nitrogen6x: add i2c2
	d653620 - ARM: dts: nitrogen6x: add hdmi
	1dffdd6 - ARM: dts: nitrogen6x: add i2c3

Eric Nelson (3):
  ARM: dts: sabrelite: add i2c2
  ARM: dts: sabrelite: add hdmi
  ARM: dts: sabrelite: add i2c3

 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Re-sending to add Shawn Guo to the CC list.

-- 
1.9.1
