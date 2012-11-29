From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Nov 2012 14:24:25 +0000
Subject: [GIT PULL] ARM: final SoC fixes for 3.7
Message-ID: <201211291424.25711.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

These should be the last bug fixes you get from Olof and me for 3.7.
This is based on the previous one you pulled and there is nothing
spectacular in here. I'll follow up with a second pull request
knowing that those are probably too late now, but I'd like to let
you know about the ones that didn't make it and give you the chance
to pull those anyway if you prefer.

	Arnd

  Merge branch 'v3.7-samsung-fixes-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into fixes (2012-11-22 20:43:37 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

for you to fetch changes up to 9434d24b11ccceeb39522965593ef2ddc9eb4e7c:

  Merge branch 'v3.7-samsung-fixes-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into fixes (2012-11-29 15:07:27 +0100)

----------------------------------------------------------------

ARM: SoC fixes for 3.7

These are three fixes for the Marvell EBU family and one for the Samsung
s3c platforms. All of them are obvious should still make it into 3.7.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge branch 'v3.7-samsung-fixes-4' of git://git.kernel.org/.../kgene/linux-samsung into fixes

Jason Gunthorpe (1):
      ARM: Kirkwood: Update PCI-E fixup

Olof Johansson (1):
      Merge tag 'orion_fixes_for_3.7' of git://git.infradead.org/users/jcooper/linux into fixes

Russell King - ARM Linux (2):
      Dove: Attempt to fix PMU/RTC interrupts
      Dove: Fix irq_to_pmu()

Sachin Kamat (1):
      ARM: S3C24XX: Fix potential NULL pointer dereference error

 arch/arm/Kconfig                     |    1 +
 arch/arm/mach-dove/include/mach/pm.h |    2 +-
 arch/arm/mach-dove/irq.c             |   14 +++++++++++++-
 arch/arm/mach-kirkwood/pcie.c        |   11 ++++++++---
 arch/arm/plat-s3c24xx/dma.c          |    9 +++++----
 5 files changed, 28 insertions(+), 9 deletions(-)
