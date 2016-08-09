From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Aug 2016 14:19:02 +0200
Subject: [PATCH 0/2] ARM: dts: alt: add SDHI0 and 1, and MMCIF support
Message-ID: <1470745144-5394-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables SDHI 0 and 1, and MMCIF on the r8a7794/Alt board.
The SDHI IP blocks are exposed as SD card slots while the MMCIF block
is wired up to on-board eMMC.

N.B.: I do not currently have physical access to an Alt board but I do
      have remote access which I used to test these patches.

Simon Horman (2):
  ARM: dts: alt: add SDHI0 and 1 support
  ARM: dts: alt: add MMCIF support

 arch/arm/boot/dts/r8a7794-alt.dts | 106 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
