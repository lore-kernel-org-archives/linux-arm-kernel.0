From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 29 May 2015 09:56:54 +0200
Subject: [PATCH v2 0/2] ARM: dts: add Okaya LCD panel for Nitrogen and
 Sabrelite
In-Reply-To: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1432886216-2717-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the Okaya 7" LCD support as a simple panel for both Nitrogen
and Sabrelite.

It requires a patch from Philipp that adds panel support to the imx parallel
display driver.
https://patchwork.kernel.org/patch/6438311/

Also requires the patch that adds the Okaya display support to the simple
panel driver.
https://patchwork.kernel.org/patch/6503261/

A U-Boot script to configure the displays based on detection of the
touch controller is available for reference here:
https://github.com/boundarydevices/u-boot-imx6/blob/staging/board/boundary/nitrogen6x/6x_bootscript-mainline.txt

Gary Bisson (2):
  ARM: dts: imx6qdl-nitrogen6x: add Okaya LCD panel
  ARM: dts: imx6qdl-sabrelite: add Okaya LCD panel

 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 76 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 76 ++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 2 deletions(-)

-- 
2.1.4
