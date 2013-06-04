From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue,  4 Jun 2013 13:07:07 +0200
Subject: [PATCH 0/8] update MBa53 support
Message-ID: <1370344035-7417-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This adds misc stuff to the MBa53 DT:
	- Sound support
	- pinctrl fixups
	- USB
	- Television Encoder
	- Display support

The series is rebased to Shawns for-next branch.

It was tested with and depends on the series
	updates for tqma53.dtsi
	<1370337150-18487-1-git-send-email-s.trumtrar@pengutronix.de>

The Television Encoder patch from Philipp depends on the Patch
	ARM i.MX53: Add TVE entry to i.MX53 dtsi
	<1370340742-25172-1-git-send-email-s.trumtrar@pengutronix.de>

Regards,
Steffen

Markus Niebel (4):
  ARM i.MX53: mba53: add sound support
  ARM i.MX53: mba53: add missing gpio stuff for pca9554
  ARM i.MX53: mba53: use reset gpio for FEC
  ARM i.MX53: mba53: add DI1_CLK to pinctrl for disp1

Michael Olbrich (1):
  ARM i.MX53: mba53: enable usbotg & usbh1

Philipp Zabel (1):
  ARM i.MX53: mba53: add Tevision Encoder

Sascha Hauer (1):
  ARM i.MX53: mba53: Add display support

Steffen Trumtrar (1):
  ARM i.MX53: mba53: fix lvds/disp pinctrl

 arch/arm/boot/dts/imx53-mba53.dts | 175 ++++++++++++++++++++++++++++++--------
 1 file changed, 138 insertions(+), 37 deletions(-)

-- 
1.8.2.rc2
