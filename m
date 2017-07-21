From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 22 Jul 2017 00:58:32 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.13 #2
Message-ID: <20170721225832.vwufkhxyy6clnprg@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Two DT patches for 4.13, fixing NAND flash support on sama5d2.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.13-dt-fixes

for you to fetch changes up to 8ff235fe7a8c4a5824c223b9996457174442e73a:

  ARM: dts: at91: sama5d2: fix EBI/NAND controllers declaration (2017-07-17 11:37:39 +0200)

----------------------------------------------------------------
DT fixes for 4.13:

 - Fix NAND flash support for sama5d2

----------------------------------------------------------------
Ludovic Desroches (2):
      ARM: dts: at91: sama5d2: use sama5d2 compatible string for SMC
      ARM: dts: at91: sama5d2: fix EBI/NAND controllers declaration

 arch/arm/boot/dts/sama5d2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170722/fe1b6d23/attachment.sig>
