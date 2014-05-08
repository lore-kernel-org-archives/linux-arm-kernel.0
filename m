From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 May 2014 17:53:52 -0500
Subject: [GIT PULL] Allwinner fixes for 3.15
Message-ID: <20140508225352.GA13825@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git 

for you to fetch changes up to 84e108fc7b23310fb6d93a657e47181d64ab6e93:

  ARM: sunxi: Enable GMAC in sunxi_defconfig (2014-05-01 17:07:42 -0700)

----------------------------------------------------------------
Set of fixes for the Allwinner support for 3.15

Some minor things, the major thing being the enabling of the GMAC driver in
sunxi_defconfig that will un-break Olof's autobooters.

----------------------------------------------------------------
Emilio L?pez (1):
      ARM: sun7i: fix PLL4 clock and add PLL8

Maxime Ripard (2):
      ARM: sun7i: Fix i2c4 base address
      ARM: sunxi: Enable GMAC in sunxi_defconfig

 arch/arm/boot/dts/sun7i-a20.dtsi | 14 +++++++++++---
 arch/arm/configs/sunxi_defconfig |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/beb51225/attachment.sig>
