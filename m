From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 21 Nov 2018 12:16:23 +0100
Subject: [GIT PULL] ARM: at91: fixes for 4.20
Message-ID: <20181121111623.GA10372@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

A simple DT fix that is necessary to get reliable access to the NAND on
sama5d2 based boards.

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-fixes

for you to fetch changes up to 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:

  ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)

----------------------------------------------------------------
AT91 fixes for 4.20

 - Fix the SMC parent clock

----------------------------------------------------------------
Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181121/efce2b4f/attachment.sig>
