From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 22:05:35 +0200
Subject: [GIT PULL] Allwinner defconfig patches for 4.8
Message-ID: <20160705200535.GA20083@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following defconfig changes for the 4.8 merge window.

Thanks!
Maxime

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.8

for you to fetch changes up to 684d2d7ca35a97a6154cff46413f65a92bb14336:

  ARM: sunxi: Enable sun4i DRM driver (2016-05-30 08:29:36 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 4.8

Two patches to enable the DRM driver in the sunxi and multi_v7 defconfig.

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: multi_v7: Enable sun4i DRM driver
      ARM: sunxi: Enable sun4i DRM driver

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 2 ++
 2 files changed, 3 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/6580e34e/attachment.sig>
