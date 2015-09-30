From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed, 30 Sep 2015 15:05:18 +0200
Subject: [RESEND][PATCH v3 0/2] ARM: dts: add Okaya LCD display for Nitrogen
 and Sabrelite
In-Reply-To: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1432314867-30888-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1443618320-12708-1-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a resend of my v3 with Shawn's correct e-mail address. I've also
made sure it applies (and builds) on latest linux-next 20150930.

This series adds the Okaya 7" LCD support as a simple panel for both Nitrogen
and Sabrelite.

This v3 updates the series as the compatible name has been changed from
"okaya,rs800480t_7x0gp" to "okaya,rs800480t-7x0gp" when the drm patch has been
merged into linux-next branch.
http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=ec9000c

Also note that Philipp Zabel's patch that enables the parallel-display driver
to work with a simple panel has been merged.
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=553a59f

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
2.5.3
