From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 18 Jul 2014 16:07:55 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.16, 2nd take
Message-ID: <20140718080754.GC8537@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4c834452aad01531db949414f94f817a86348d59:

  Linux 3.16-rc3 (2014-06-29 14:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-3.16-2

for you to fetch changes up to 03e97220b99b8b691ea5b130b7b4c135c9662792:

  ARM: clk-imx6q: parent lvds_sel input from upstream clock gates (2014-07-18 15:57:17 +0800)

----------------------------------------------------------------
The i.MX fixes for 3.16, 2nd take:

It fixes a hard machine hang regression for boards where only pcie is
active but no sata, as the latest imx6-pcie driver is no longer enabling
the upstream clock directly but only lvds clk out.

----------------------------------------------------------------
Lucas Stach (1):
      ARM: clk-imx6q: parent lvds_sel input from upstream clock gates

 arch/arm/mach-imx/clk-imx6q.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
