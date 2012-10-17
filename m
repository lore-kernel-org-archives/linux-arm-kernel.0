From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Oct 2012 16:38:15 +0900
Subject: [PATCH 0/8] Cragganmore updates
Message-ID: <20121017073813.GI14199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git tags/crag6410

for you to fetch changes up to c8a825563eae03e657b191c2b4948f7613ae91b6:

  ARM: S3C64XX: Add handset module to probed Glenfarclas modules (2012-10-16 14:09:01 +0900)

----------------------------------------------------------------
ARM: S3C64XX: Cragganmore updates

There's a bunch of things in here (some have been posted before I
believe), the main thing is the update to support muliple board
revisions but there's also some new modules added.

----------------------------------------------------------------
Mark Brown (8):
      ARM: S3C64XX: Add more Glenfarclas module ID strings
      ARM: S3C64XX: Update hookup for Arizona class devices
      ARM: S3C64XX: Provide platform data for Tomatin/Balblair on Cragganmore
      ARM: S3C64XX: Handle revision-specific differences in Cragganmore modules
      ARM: S3C64XX: Handle new Amrut modules on Cragganmore
      ARM: S3C64XX: Add hookup for Deanston module on Cragganmore
      ARM: S3C64XX: Add WM2200 module for Cragganmore
      ARM: S3C64XX: Add handset module to probed Glenfarclas modules

 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  141 +++++++++++++++++++++-----
 arch/arm/mach-s3c64xx/mach-crag6410.c        |   29 +++++-
 2 files changed, 144 insertions(+), 26 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/62e1e0ed/attachment.sig>
