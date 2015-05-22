From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 22 May 2015 19:14:25 +0200
Subject: [PATCH 0/2] ARM: dts: add Okaya LCD display for Nitrogen and Sabrelite
Message-ID: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the Okaya 7" LCD display that is a WVGA (800x480) panel with
a 18-bit parallel interface for both Nitrogen and Sabrelite.

A U-Boot script to configure the displays based on detection of the
touch controller is available for reference here:
https://github.com/boundarydevices/u-boot-imx6/blob/staging/board/boundary/nitrogen6x/6x_bootscript-mainline.txt

Gary Bisson (2):
  ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD display
  ARM: dts: imx6qdl-sabrelite: add Okaya LCD display

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 70 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 70 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.1.4
