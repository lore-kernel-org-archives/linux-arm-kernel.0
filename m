From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:46:28 -0800
Subject: [GIT PULL] arm: Allwinner defconfig changes for 4.6
Message-ID: <20160226194628.GA20693@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-defconfig-for-4.6

for you to fetch changes up to 3d0ddadbe6dde5639f565e3456ae112679e288af:

  ARM: sunxi_defconfig: Enable MUSB HDRC driver with Allwinner glue (2016-02-09 19:30:57 +0100)

----------------------------------------------------------------
Allwinner defconfig changes for 4.6

A bunch of changes to add new drivers to the sunxi and multi_v7 defconfigs,
most notably the USB OTG that is finally enabled.

----------------------------------------------------------------
Chen-Yu Tsai (6):
      ARM: sunxi_defconfig: Enable sunxi IR driver
      ARM: sunxi_defconfig: Enable A10 audio codec driver
      ARM: sunxi_defconfig: Enable INPUT_EVDEV so axp20x-pek can be used
      ARM: multi_v7_defconfig: Enable MUSB HDRC driver with Allwinner glue
      ARM: multi_v7_defconfig: Enable A10 audio codec driver as module
      ARM: sunxi_defconfig: Enable MUSB HDRC driver with Allwinner glue

 arch/arm/configs/multi_v7_defconfig |  3 +++
 arch/arm/configs/sunxi_defconfig    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/8cf2d95b/attachment-0001.sig>
