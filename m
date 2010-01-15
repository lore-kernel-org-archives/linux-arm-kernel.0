From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 08:10:45 +0000
Subject: [PULL] Please pull bjdooks' for-linus/samsung branch
Message-ID: <20100115081045.GA13888@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 004b35063296b6772fa72404a35b498f1e71e87e:
  Linus Torvalds (1):
        Merge branch 'drm-linus' of git://git.kernel.org/.../airlied/drm-2.6

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git for-linus/samsung

Ben Dooks (1):
      ARM: MINI2440: Fixup __initdata usage

Mark Brown (1):
      ARM: SMDK6410: Specify no GPIO for B_PWR_5V regulator

Ramax Lo (1):
      ARM: S3C: NAND: Check the existence of nr_map before copying

Uri Yosef (1):
      ARM: MINI2440: Fix crash on boot due to improper __initdata qualifier

 arch/arm/mach-s3c2440/mach-mini2440.c |   36 ++++++++++++++++----------------
 arch/arm/mach-s3c6410/mach-smdk6410.c |    1 +
 arch/arm/plat-s3c/dev-nand.c          |    4 +-
 3 files changed, 21 insertions(+), 20 deletions(-)

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
