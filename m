From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 25 Dec 2014 14:12:20 +0800
Subject: [PATCH 0/2] ARM: dts: berlin: enable PMU and add PPI cpu mask to twd
 interrupts
Message-ID: <1419487942-2277-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the patch enables PMU support to BG2Q and BG2CD SoCs. Another patch
adds the missing PPI cpu mask to twd timer interrupts.

Jisheng Zhang (2):
  ARM: dts: berlin: add pmu node for BG2Q and BG2CD
  ARM: dts: berlin: add PPI cpu mask to twd timer interrupts

 arch/arm/boot/dts/berlin2.dtsi   |  3 ++-
 arch/arm/boot/dts/berlin2cd.dtsi |  8 +++++++-
 arch/arm/boot/dts/berlin2q.dtsi  | 11 ++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.1.4
