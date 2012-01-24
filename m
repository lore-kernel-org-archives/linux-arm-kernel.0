From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jan 2012 21:31:27 +0000
Subject: [PATCH 0/4] Pending S3C64xx updates
Message-ID: <20120124213127.GH1135@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is a collection of s3c64xx updates I've had hanging
round in my tree for varying lengths of time that it'd be good to get
merged.  There's no particularly relationship between them except that
they're all for s3c64xx.

Mark Brown (4):
      ARM: S3C64XX: Make s3c64xx_init_uarts() static
      ARM: S3C64XX: Define some additional always off clocks
      ARM: S3C6410: Use device names for both I2C clocks
      ARM: S3C64XX: Add hookup for Tomatin module on Cragganmore

 arch/arm/mach-s3c64xx/clock.c                |  106 ++++++++++++++++++++++++++
 arch/arm/mach-s3c64xx/common.c               |    2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   27 ++++++-
 arch/arm/mach-s3c64xx/mach-crag6410.c        |   11 +++-
 4 files changed, 143 insertions(+), 3 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/09286098/attachment.sig>
