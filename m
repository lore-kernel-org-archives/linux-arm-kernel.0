From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 14:19:48 +0100
Subject: [GIT PULL] RealView defconfig updates
Message-ID: <CACRpkdbpOs24tx6pmPGaetDqu-VeD+pkUDb7BCw7n+KKUJP_oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some updates to the RealView defconfigs, that make the
system modern and testable. Mostly stuff that should have been
enabled ages ago.

Whether it should go directly to the -rc:s or next merge window
is up to the ARM SoC maintainers.

Please pull it it!

Yours,
Linus Walleij

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52bb9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-defconfig-for-armsoc

for you to fetch changes up to 8948f8aeb2eaaf0d729aa70965e16d2a4482b48c:

  ARM: realview: add generic config options (2015-12-10 14:09:58 +0100)

----------------------------------------------------------------
RealView defconfig updates, details in the commit log.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: realview: refresh defconfig
      ARM: realview: update SMP defconfig
      ARM: realview: add generic config options
      ARM: realview: add generic config options

 arch/arm/configs/realview-smp_defconfig | 29 +++++++++++------------------
 arch/arm/configs/realview_defconfig     | 26 +++++++++-----------------
 2 files changed, 20 insertions(+), 35 deletions(-)
