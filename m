From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:46:53 -0800
Subject: [GIT PULL] arm: Allwinner drivers changes for 4.6
Message-ID: <20160226194653.GA20934@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.6

for you to fetch changes up to febe6569fae4b5e663f0a31d9dbf054d3b588ff5:

  drivers: soc: sunxi: Fix mask generation for SRAM mapping (2016-01-27 20:29:20 +0100)

----------------------------------------------------------------
Allwinner drivers changes for 4.6

Some minor fixes for the RSB and SRAM controller drivers

----------------------------------------------------------------
Andre Przywara (1):
      drivers: sunxi-rsb: fix error output type

Jens Kuske (1):
      drivers: soc: sunxi: Fix mask generation for SRAM mapping

 drivers/bus/sunxi-rsb.c        | 4 ++--
 drivers/soc/sunxi/sunxi_sram.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/174cfbf7/attachment.sig>
