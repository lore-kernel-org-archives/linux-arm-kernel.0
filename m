From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 May 2016 10:49:06 +0200
Subject: [GIT PULL] Ux500 defconfig updates for v4.7
Message-ID: <CACRpkdaf39+gQzBb5U9gM5n17QwsNd7FxTbd3J+hLcuBNczKWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some defconfig updates for the v4.7 merge cycle.
Please pull them in to whatever defconfig branch is apropriate.

Yours,
Linus Walleij


The following changes since commit 04974df8049fc4240d22759a91e035082ccd18b4:

  Linux 4.6-rc6 (2016-05-01 15:52:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-defconfig-armsoc

for you to fetch changes up to 95d48536d51c946a69ba251f2a198a3f63abe521:

  ARM: u8500_defconfig: update sensor config (2016-05-02 10:42:58 +0200)

----------------------------------------------------------------
Ux500 defconfig update for v4.7:
- Remove the unused MACH_UX500_DT option from the multi_v7 defconfig
- Remove staging driver from u8500_defconfig
- Update sensor support in u8500_defconfig

----------------------------------------------------------------
Lee Jones (1):
      ARM: multi_v7_defconfig: Remove unused Kconfig option MACH_UX500_DT

Linus Walleij (2):
      ARM: u8500_defconfig: remove staging from defconfig
      ARM: u8500_defconfig: update sensor config

 arch/arm/configs/multi_v7_defconfig | 1 -
 arch/arm/configs/u8500_defconfig    | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)
