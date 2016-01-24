From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 25 Jan 2016 01:29:23 +0900
Subject: [PATCH] ARM: dts: kirkwood: add device tree for buffalo linkstation
 ls-qvl;
Message-ID: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kirkwood Maintainers,

Mario created dts for Linkstation LS-QVL, which is 4-bay NAS, based
on my dts for 2-bay LS-WVL.
He asked me to post the dts to ARM on hehalf of him, so here I created
the patch set!

Roger Shimizu (1):
  ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 135 +++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts

-- 
2.1.4
