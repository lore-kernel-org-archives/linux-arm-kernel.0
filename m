From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 06 Sep 2014 22:48:44 +0200
Subject: [PATCH 0/2] ARM: mvebu: Use Hardware BCH ECC for RN104 and RN2120
Message-ID: <cover.1410035142.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following Ben's report and fix for RN102, I did some tests
on RN104 and RN2120 (they have the same Hynix H27U1G8F2BTR
flash and setup) and came up w/ the exact same fixes for
their respective .dts files. With those patches, it is now
possible to update kernel from userland and u-boot will
happily load and boot it on those devices.

Both patches should be candidates for stable, I guess.

Cheers,

a+

Arnaud Ebalard (2):
  ARM: mvebu: Netgear RN104: Use Hardware BCH ECC
  ARM: mvebu: Netgear RN2120: Use Hardware BCH ECC

 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 4 ++++
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.1.0
