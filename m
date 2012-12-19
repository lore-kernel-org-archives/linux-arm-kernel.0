From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Dec 2012 09:46:00 +0100
Subject: [GIT PULL] Fixes for sunxi for 3.8 merge window
Message-ID: <1355906760-23041-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please consider pulling these two (late) patches for the sunxi support.

The first one add the support for the sunxi architecture in the multiplatform
kernel, allowing to easily build a kernel that boots on the sun4i/sun5i
supported boards.

The second one fixes some compatible strings that were left behind in the
previous compatible renaming patch, preventing the kernel from booting.

Thanks,
Maxime 

The following changes since commit 7445d6b5a7a40c40cda3935ba3827896305cfc21:

  ARM: sunxi: Change device tree naming scheme for sunxi (2012-12-18 15:11:16 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8-rc1

for you to fetch changes up to 91e4f61216c6e15f7ff99f2d18407a08cfe601b0:

  sunxi: Change the machine compatible string. (2012-12-19 09:23:42 +0100)

----------------------------------------------------------------
Fixes for the sunxi core to be merged in 3.8-rc1

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: multi_v7_defconfig: Add ARCH_SUNXI
      sunxi: Change the machine compatible string.

 arch/arm/configs/multi_v7_defconfig |    1 +
 arch/arm/mach-sunxi/sunxi.c         |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
