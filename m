From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 14:04:23 +0100
Subject: [PATCH  0/2] Add BQ32000 RTC support for iWave RZ/G1M board
Message-ID: <1502197465-61546-1-git-send-email-biju.das@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series aims to add BQ32000 RTC support for iWave RZ/G1M board.

This series has been tested against Linux-next tag 20170727 and renesas-dev branch.
This patch series depends on https://www.spinics.net/lists/arm-kernel/msg599220.html

Biju Das (2):
  ARM: dts: iwg20d-q7: Add RTC support
  ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig

 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
 arch/arm/configs/shmobile_defconfig     |  1 +
 2 files changed, 19 insertions(+)

-- 
1.9.1
