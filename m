From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Sep 2016 19:41:10 +0200
Subject: [PATCH 0/2] Armada 7k/8k SPI0 clock references fix
Message-ID: <1473183672-12028-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This tiny patchset comprises fixes for SPI0 interfaces in both
Armada 7k/8k CP110 HW blocks. It's split into two, because
the fix in armada-cp110-master.dtsi is applicable also on
v4.7 stable branch (cc'ed).

Any feedback would be welcome.

Best regards,
Marcin

Marcin Wojtas (2):
  arm64: dts: marvell: fix clocksource for CP110 master SPI0
  arm64: dts: marvell: fix clocksource for CP110 slave SPI0

 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.1
