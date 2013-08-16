From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Aug 2013 20:55:24 +0200
Subject: [GIT PULL] Allwinner sunXi core additions for 3.12
Message-ID: <20130816185524.GA29790@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.12

for you to fetch changes up to 29d3d373e2a780b6e818f296ece6cc29742bc11f:

  ARM: sunxi: Remove Makefile.boot file (2013-07-29 13:55:41 +0200)

----------------------------------------------------------------
Allwinner sunXi core additions for 3.12

There's not much in this pull request, only a patch removing some dead code.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: sunxi: Remove Makefile.boot file

 arch/arm/mach-sunxi/Makefile.boot | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-sunxi/Makefile.boot

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/1ef036de/attachment.sig>
