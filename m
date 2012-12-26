From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Dec 2012 19:42:03 +0100
Subject: [GIT PULLv2] Fixes for sunXi for 3.8
Message-ID: <50DB44FB.30603@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the two fixes I sent previously rebased on top of 3.8-rc1.

The first one add the support for the sunxi architecture in the multiplatform
kernel, allowing to easily build a kernel that boots on the sun4i/sun5i
supported boards.

The second one fixes some compatible strings that were left behind in the
previous compatible renaming patch, preventing the kernel from booting.

Thanks,
Maxime

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-fixes-for-3.8-rc2

for you to fetch changes up to 43880f709dc59840849e31b01735ac587195ef8a:

  sunxi: Change the machine compatible string. (2012-12-23 18:20:15 +0100)

----------------------------------------------------------------
Fixes for the sunxi core to be merged in 3.8-rc2

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: multi_v7_defconfig: Add ARCH_SUNXI
      sunxi: Change the machine compatible string.

 arch/arm/configs/multi_v7_defconfig |    1 +
 arch/arm/mach-sunxi/sunxi.c         |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
