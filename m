From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Oct 2014 14:13:04 +0200
Subject: [GIT PULL] Integrator multiplatform migration for v3.19
Message-ID: <CACRpkdafst1j2tp4-=BZMn_P688uUSjeAZEGt26WuD_d521sHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is the initial set of two patches to migrate the Integrator
platforms to multiplatform.

Tested on the Integrator/AP with ARM926EJ-S and Integrator/CP
with ARM920T.

Please pull it in for v3.19!

Yours,
Linus Walleij

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/integrator-multiplatform-for-arm-soc

for you to fetch changes up to 9713497b6c64c67c8763f8f07fad325b193764b6:

  ARM: integrator: set V4T and V5 as default multitargets (2014-10-22
09:49:26 +0200)

----------------------------------------------------------------
Multiplatform migration of the Integrator.

----------------------------------------------------------------
Linus Walleij (2):
      ARM: integrator: make the Integrator multiplatform
      ARM: integrator: set V4T and V5 as default multitargets

 arch/arm/Kconfig                                   | 18 --------
 arch/arm/configs/integrator_defconfig              |  3 ++
 arch/arm/mach-integrator/Kconfig                   | 18 ++++++++
 arch/arm/mach-integrator/include/mach/uncompress.h | 48 ----------------------
 4 files changed, 21 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/uncompress.h
