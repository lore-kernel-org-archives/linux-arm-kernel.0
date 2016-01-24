From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 25 Jan 2016 08:20:02 +0900
Subject: [PATCH v2] ARM: dts: kirkwood: add device tree for buffalo
 linkstation ls-qvl
In-Reply-To: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
References: <1453652964-21489-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <1453677603-25803-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kirkwood Maintainers,

Mario created dts for Linkstation LS-QVL, which is 4-bay NAS, based
on my dts for 2-bay LS-WVL.
He asked me to post the dts to ARM on hehalf of him, so here I created
the patch set!

Changes in v2:
  - add my "Signed-off-by"
  - fix typo in commit message

Roger Shimizu (1):
  ARM: dts: kirkwood: add device tree for buffalo linkstation ls-qvl

 .../devicetree/bindings/arm/marvell,kirkwood.txt   |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts   | 135 +++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-linkstation-lsqvl.dts

-- 
2.1.4
