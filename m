From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jul 2014 22:55:23 +0200
Subject: [GIT PULL] Allwinner core additions for 3.17
Message-ID: <20140718205523.GA28407@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof, 

Here are the few mach-sunxi patches to merge for the 3.17 release cycle.

Thanks!
Maxime

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-3.17

for you to fetch changes up to 5ba1657ecdee507df4adcd05b533d09e9934fc11:

  ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch support is enabled (2014-07-07 11:00:06 +0200)

----------------------------------------------------------------
Allwinner core additions for 3.17

Nothing very fancy here, only the introduction from the new Allwinner A23 SoC.

----------------------------------------------------------------
Chen-Yu Tsai (3):
      ARM: sunxi: Introduce Allwinner A23 support
      ARM: sunxi: Add earlyprintk support using R_UART (sun6i/sun8i)
      ARM: sunxi: select MFD_SUN6I_PRCM when sun8i arch support is enabled

 arch/arm/Kconfig.debug      | 10 ++++++++++
 arch/arm/mach-sunxi/Kconfig |  8 ++++++++
 arch/arm/mach-sunxi/sunxi.c |  9 +++++++++
 3 files changed, 27 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/658ee78b/attachment.sig>
