From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 12 Aug 2014 09:04:37 +0900
Subject: [PATCH v2 0/5] ARM: shmobile: armadillo800eva-reference: Enable CMT1
 in device tree
Message-ID: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series enables the CMT1 timer using DT on
armadillo800eva-reference.

It is based on "ARM: shmobile: r8a7740: add clocks to DT" applied
on top of renesas-devel-v3.16-20140808.

Ulrich, if you end up reposting "ARM: shmobile: r8a7740: add clocks to DT"
please consider appending this series to it.

Changes since v1
* Correct typo in change log of
  "ARM: shmobile: r8a7740: Add CMT1 device to DT"

Simon Horman (5):
  ARM: shmobile: r8a7740: Add CMT1 device to DT
  ARM: shmobile: armadillo800eva-reference: Enable CMT1 in device tree
  ARM: shmobile: armadillo800eva-reference: Sort includes
  ARM: shmobile: armadillo800eva-reference: Do not use
    r8a7740_add_standard_devices_dt()
  ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt

 .../arm/boot/dts/r8a7740-armadillo800eva-reference.dts |  4 ++++
 arch/arm/boot/dts/r8a7740.dtsi                         | 12 ++++++++++++
 .../mach-shmobile/board-armadillo800eva-reference.c    |  5 +++--
 arch/arm/mach-shmobile/r8a7740.h                       |  1 -
 arch/arm/mach-shmobile/setup-r8a7740.c                 | 18 ++----------------
 5 files changed, 21 insertions(+), 19 deletions(-)

-- 
2.0.0.rc2
