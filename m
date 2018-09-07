From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 7 Sep 2018 12:36:33 +0800
Subject: [GIT PULL] Allwinner fixes for v4.19
Message-ID: <20180907043633.GA26550@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just a resend with the proper prefix in the subject.
Sorry for the noise.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.19

for you to fetch changes up to d177c8b61d6b4ef360b1c2682e4d8e3bae01738b:

  arm64: allwinner: dts: h6: fix Pine H64 MMC bus width (2018-08-27 09:21:00 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.19

Just one fix for H6 mmc on the Pine H64: the mmc bus width was missing
from the device tree. This was added in 4.19-rc1.

----------------------------------------------------------------
Icenowy Zheng (1):
      arm64: allwinner: dts: h6: fix Pine H64 MMC bus width

 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 ++
 1 file changed, 2 insertions(+)
