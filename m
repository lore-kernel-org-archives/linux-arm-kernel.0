From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:14:14 +0200
Subject: [GIT PULL] Allwinner defconfig additions for 3.18
Message-ID: <20140920201414.GA17237@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following defconfig changes for the next merge window.

Thanks!
Maxime

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-defconfig-for-3.18

for you to fetch changes up to 9524fa523e10c75750962c4079e6d002d7487280:

  ARM: sunxi_defconfig: add NLS_CODEPAGE_437 and NLS_ISO8859_1 (2014-08-18 17:51:18 +0200)

----------------------------------------------------------------
Allwinner defconfig additions for 3.18

Nothing major, just a few drivers additions and misc options

----------------------------------------------------------------
Chen-Yu Tsai (2):
      ARM: sunxi: Add A31 RTC driver to sunxi_defconfig
      ARM: sunxi: Add A31 RTC driver to multi_v7_defconfig

Luc Verhaegen (1):
      ARM: sunxi_defconfig: add NLS_CODEPAGE_437 and NLS_ISO8859_1

 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 3 +++
 2 files changed, 4 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/98997eda/attachment.sig>
