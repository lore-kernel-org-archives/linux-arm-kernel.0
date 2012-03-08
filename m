From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Mar 2012 12:23:01 -0800
Subject: [GIT PULL] arm-soc: last minute fixes for 3.3
Message-ID: <CAOesGMg0RD1KtejF0LpqO4GUdzMtPxvpbkgONOvhGQVDSH0xsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a few last-minute arm-soc fixes for 3.3.


Thanks!

-Olof

The following changes since commit 4f262acfde22b63498b5e4f165e53d3bb4e96400:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
(2012-03-07 08:33:03 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-urgent

for you to fetch changes up to c66fcfa938d84d4661c77e9fe85312dece0133e8:

  Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
fixes (2012-03-08 10:56:12 -0800)

----------------------------------------------------------------

Last minute fixes for 3.3

One samsung build fix due to a mis-applied patch, and a small set of OMAP fixes.
This should be the last from arm-soc for 3.3, hopefully.

----------------------------------------------------------------
Cousson, Benoit (1):
      ARM: OMAP: irqs: Fix NR_IRQS value to handle PRCM interrupts

Kukjin Kim (1):
      ARM: S3C2440: Fixed build error for s3c244x

Olof Johansson (1):
      Merge branch 'fixes' of
git://git.kernel.org/.../tmlind/linux-omap into fixes

R Sricharan (1):
      ARM: OMAP2+: Fix module build errors with CONFIG_OMAP4_ERRATA_I688

Rajendra Nayak (1):
      ARM: OMAP2+: Remove apply_uV constraints for fixed regulator

Vaibhav Hiremath (1):
      ARM: OMAP: id: Add missing break statement in omap3xxx_check_revision

 arch/arm/mach-omap2/id.c               |    1 +
 arch/arm/mach-omap2/omap4-common.c     |    2 ++
 arch/arm/mach-omap2/twl-common.c       |    1 -
 arch/arm/mach-s3c2440/s3c244x.c        |    1 +
 arch/arm/plat-omap/include/plat/irqs.h |   10 +++++++++-
 5 files changed, 13 insertions(+), 2 deletions(-)
