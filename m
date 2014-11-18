From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Nov 2014 23:19:53 +0100
Subject: [GIT PULL] Allwinner core for 3.19
Message-ID: <20141118221953.GA19579@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are the bunch of changes to mach-sunxi for the 3.19 merge window.

This cycle has mostly been about the introduction of the A80 support.

Thanks,
Maxime

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-3.19

for you to fetch changes up to 02c24f7dc2449203a9309c6ecdb4feed2d884f43:

  ARM: sunxi: make sun6i SMP ops static (2014-11-16 11:02:33 +0100)

----------------------------------------------------------------
Allwinner Core Additions for 3.19

This has mostly been about introducing A80 support

----------------------------------------------------------------
Chen-Yu Tsai (7):
      Documentation: sunxi: Update Allwinner SoC documentation (A31/A31s/A23)
      ARM: sunxi: Add debug uart used by sun9i (Allwinner A80)
      devicetree: bindings: Add vendor prefix for Merrii Technology Co., Ltd.
      ARM: sunxi: Introduce Allwinner A80 support
      devicetree: bindings: Document supported Allwinner sunxi SoCs
      Documentation: sunxi: Add A80 datasheet link
      ARM: sunxi: Select ARCH_HAS_RESET_CONTROLLER and RESET_CONTROLLER for sun9i

Emilio L?pez (1):
      ARM: sunxi: make sun6i SMP ops static

 Documentation/arm/sunxi/README                        | 16 +++++++++++++---
 Documentation/devicetree/bindings/arm/sunxi.txt       | 12 ++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
 arch/arm/Kconfig.debug                                | 10 ++++++++++
 arch/arm/mach-sunxi/Kconfig                           |  7 +++++++
 arch/arm/mach-sunxi/platsmp.c                         |  2 +-
 arch/arm/mach-sunxi/sunxi.c                           |  9 +++++++++
 7 files changed, 53 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/c0aa56f5/attachment.sig>
