From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jan 2014 09:00:31 +0100
Subject: [GIT PULL] minor Versatile updates
Message-ID: <CACRpkdZFDCScea24A=CnV+Yxv-nZGxFKfhQsbvMHbxywwatPsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

the following is just one minor cleanup and then defconfig changes to
set the scene for future Versatile cleanup/multiplatform work.

Please pull it in to ARM SoC, the defconfig changes are even post-rc1
material in some sense.

Yours,
Linus Walleij


The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-for-v3.14

for you to fetch changes up to 27d2adb5969eef7ff3bfeb2dc3b2064e3a124952:

  ARM: versatile: enable LEDs by default (2013-12-20 18:22:49 +0100)

----------------------------------------------------------------
Versatile patches for v3.14:

- Move GPIO2 and GPIO3 to be registered from the core boardfile.

- Update the defconfig.

Defconfig changes:

- Enable GPIOLIB and PL061 for the Versatile.

- Build the Versatile using EABI.

- Enable the new LEDs in the defconfig.

----------------------------------------------------------------
Linus Walleij (5):
      ARM: versatile: move GPIO2 and GPIO3 to core
      ARM: versatile: update defconfig
      ARM: versatile: enable GPIOLIB and PL061 by default
      ARM: versatile: build using EABI
      ARM: versatile: enable LEDs by default

 arch/arm/configs/versatile_defconfig   | 26 ++++++++++++--------------
 arch/arm/mach-versatile/core.c         | 16 ++++++++++++++++
 arch/arm/mach-versatile/versatile_pb.c | 21 ---------------------
 3 files changed, 28 insertions(+), 35 deletions(-)
