From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Dec 2015 13:08:48 +0100
Subject: [GIT PULL] Allwinner defconfig changes for 4.5
Message-ID: <20151214120848.GA23059@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull this bunch of defconfig changes for the 4.5 merge window.

Thanks!
Maxime

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.5

for you to fetch changes up to 263350adb2235dbe7d38763812a9b05ab56795bc:

  ARM: sunxi: Clean up sunxi_defconfig (2015-11-20 12:48:13 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 4.5

A bunch of patches to enable new drivers related to Allwinner SoCs.

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi_defconfig: Update MFD_AXP20X symbol and enable MFD_AXP20X_RSB
      ARM: multi_v7_defconfig: Enable RSB and AXP20X related drivers as modules

Timo Sigurdsson (4):
      ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
      ARM: sunxi: Re-enable SID driver in sunxi_defconfig
      ARM: sunxi: Really enable LRADC keys in sunxi_defconfig
      ARM: sunxi: Clean up sunxi_defconfig

 arch/arm/configs/multi_v7_defconfig | 11 ++++++++---
 arch/arm/configs/sunxi_defconfig    | 14 +++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/2ce5bd93/attachment.sig>
