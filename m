From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 16:52:24 +0200
Subject: [PATCH 0/3] ARM: mxs: Various Crystalfontz DT additions
Message-ID: <1372258347-18422-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series add DT for the Crystalfontz CFA-10056 and Crystalfontz
CFA-10058.

The first patch simplifies board detection in mach-mxs.c as suggested by Thomas
Petazzoni in his review of the precedent DT additions.

The next patches are ading the DTs.

Thanks,
Alexandre

Alexandre Belloni (1):
  ARM: mxs: Simplify detection of CrystalFontz boards

Brian Lilly (2):
  ARM: mxs: dt: Add Crystalfontz CFA-10056 device tree
  ARM: mxs: dt: Add Crystalfontz CFA-10058 device tree

 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/imx28-cfa10056.dts | 200 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-cfa10058.dts | 183 ++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c         |   5 +-
 4 files changed, 386 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10056.dts
 create mode 100644 arch/arm/boot/dts/imx28-cfa10058.dts

-- 
1.8.1.2
