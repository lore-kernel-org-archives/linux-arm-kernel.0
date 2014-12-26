From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 26 Dec 2014 16:57:58 +0800
Subject: [PATCH v2 0/3] ARM: dts: berlin: add PMU and twd's cpu mask and fix
 GPIO locations
Message-ID: <1419584281-4811-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches try to improve dts for berlin. One of them enables PMU support
to BG2Q and BG2CD SoCs. One of them adds the missing PPI cpu mask to twd timer
interrupts. The last one corrects the SM GPIOs' location for BG2Q SoC.

Changes since v1:
 - Adds some text to the log of the second commit
 - Adds the patch to fix SM GPIO locations

Jisheng Zhang (3):
  ARM: dts: berlin: add pmu node for BG2Q and BG2CD
  ARM: dts: berlin: add PPI cpu mask to twd timer interrupts
  ARM: dts: berlin: correct BG2Q's SM GPIO location.

 arch/arm/boot/dts/berlin2.dtsi   |  2 +-
 arch/arm/boot/dts/berlin2cd.dtsi |  7 +++-
 arch/arm/boot/dts/berlin2q.dtsi  | 70 ++++++++++++++++++++++------------------
 3 files changed, 46 insertions(+), 33 deletions(-)

-- 
2.1.4
