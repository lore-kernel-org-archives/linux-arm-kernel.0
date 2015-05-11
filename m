From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 May 2015 21:36:48 +0200
Subject: [GIT PULL] Allwinner core changes for 4.2
Message-ID: <20150511193648.GA29957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the first batch of changes for mach-sunxi for 4.2.

thanks!
Maxime

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.2

for you to fetch changes up to 7917d14129a5a7241289f06d2c5299c5d03ed529:

  ARM: sun8i: Add SMP support for the Allwinner A23 (2015-04-27 08:16:33 +0200)

----------------------------------------------------------------
Allwinner core additions for 4.2

This pull request contains only the changes needed to support the SMP on
the Allwinner A23.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: sun8i: Add SMP support for the Allwinner A23

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-sunxi/platsmp.c                  | 69 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/6fcfb716/attachment.sig>
