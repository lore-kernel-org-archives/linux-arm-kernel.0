From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Mar 2014 17:42:50 +0100
Subject: [GIT PULL] Allwinner defconfig additions for 3.15
Message-ID: <20140313164250.GA13112@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Please pull the following changes for 3.15.

Thanks!

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-defconfig-for-3.15

for you to fetch changes up to 4f26b761531c00605010d595b495901106729f8b:

  ARM: sunxi: Enable A31 SPI and SID in the defconfig (2014-02-07 20:26:40 +0100)

----------------------------------------------------------------
Allwinner defconfig additions for 3.15

Enables SPI and SID drivers in sunxi defconfig

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Enable A31 SPI and SID in the defconfig

 arch/arm/configs/sunxi_defconfig | 3 +++
 1 file changed, 3 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/4652e06e/attachment.sig>
