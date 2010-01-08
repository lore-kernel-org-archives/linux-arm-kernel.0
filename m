From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 08 Jan 2010 02:10:53 +0000
Subject: Please pull bjdooks' for-linus/samsung
Message-ID: <E1NT4JR-0006WN-6J@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c5974b835a909ff15c3b7e6cf6789b5eb919f419:
  Linus Torvalds (1):
        Merge branch 'limits_cleanup' of git://decibel.fi.muni.cz/~xslaby/linux

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/samsung

Ben Dooks (1):
      ARM: S3C64XX: Fix possible clock look in EPLL and MPLL clock chains

 arch/arm/plat-s3c64xx/s3c6400-clock.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)
