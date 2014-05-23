From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 20:15:05 +0200
Subject: [GIT PULL] Allwinner defconfig changes for 3.16, take 2
Message-ID: <20140523181505.GA9674@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the last bunch of defconfig changes for the 3.16 merge
window.

It comes on top of the previous defconfig pull request.

The following changes since commit 5659e3bcbcb5d454fa183351362e852321784f7c:

  ARM: sunxi: drop CONFIG_COMMON_CLK_DEBUG (2014-05-10 12:07:50 -0400)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-defconfig-for-3.16-2

for you to fetch changes up to e397a78589e03ce920e0b4e5f8cc2cfa49027058:

  ARM: multi_v7: Add Allwinner reset drivers to multi_v7_defconfig (2014-05-23 10:39:49 +0200)

----------------------------------------------------------------
Allwinner defconfig changes, take 2

Add the A31 reset driver to the sunxi-related defconfigs

----------------------------------------------------------------
Maxime Ripard (2):
      ARM: sunxi: Add A31 reset driver to sunxi_defconfig
      ARM: multi_v7: Add Allwinner reset drivers to multi_v7_defconfig

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/sunxi_defconfig    | 3 +++
 2 files changed, 5 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/5fc49dda/attachment.sig>
