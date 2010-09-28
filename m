From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 28 Sep 2010 22:12:30 +0200
Subject: imx patches for 2.6.37
In-Reply-To: <20100927135009.GC6271@pengutronix.de>
References: <20100927135009.GC6271@pengutronix.de>
Message-ID: <20100928201230.GJ26352@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here come five more patches

The following changes since commit 24bc0ba6ebf7b615fdc67f3c09c467e0d5752168:

  ARM: mx5: clock-imx51: make *ipg clocks secondary clocks of their corresponding peripheral clocks (2010-09-27 17:00:58 +0200)

(which was the last patch of the previous series) are available in the
git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/for-2.6.36

Uwe Kleine-K?nig (5):
      ARM: imx/clock-imx27: Pass NULL as function callback, not 0
      ARM: imx/pcm038: make regulator platform data static
      ARM: imx: make all pin lists const and signed, move to .init where possible
      ARM: imx/pcm970: make platform_data static
      ARM: imx/pca100: only specify i2c device type once

 arch/arm/mach-imx/clock-imx27.c              |   42 +++++++++++++-------------
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c            |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c  |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c           |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c              |    2 +-
 arch/arm/mach-imx/mach-mx21ads.c             |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c            |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c             |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c            |    2 +-
 arch/arm/mach-imx/mach-pca100.c              |    6 +--
 arch/arm/mach-imx/mach-pcm038.c              |    4 +-
 arch/arm/mach-imx/mach-scb9328.c             |    2 +-
 arch/arm/mach-imx/pcm970-baseboard.c         |    4 +-
 14 files changed, 37 insertions(+), 39 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
