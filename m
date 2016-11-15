From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:03:42 +0100
Subject: [GIT PULL] Allwinner defconfig changes for 4.10
Message-ID: <20161115210342.vz6k5ihsfl4gx4nu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.10

for you to fetch changes up to a0eb3ee3c8dbe918c397eaf52ea0c887defd35a7:

  ARM: multi_v7: enable VGA bridge (2016-10-16 14:31:52 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 4.10

Two patches to enable the dumb VGA bridges in the multi_v7 and sunxi
defconfig.

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sunxi: Enable VGA bridge
      ARM: multi_v7: enable VGA bridge

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 1 +
 2 files changed, 2 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/43a599eb/attachment.sig>
