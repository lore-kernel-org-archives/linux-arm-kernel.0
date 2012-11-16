From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Nov 2012 19:01:58 +0100
Subject: [PATCH 0/2] Add clock gating support for Armada 370/XP
In-Reply-To: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
Message-ID: <1353088920-17458-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

With this 2 patches I added clock gating support for Armada 370 and
Armada XP. I compiled and tested on the boards, and managed to see the
new clock using debugfs.

Feel free to squash them in your series if you want.

Regards,

Gregory CLEMENT (2):
  clk: mvebu: armada 370/XP add clock gating control provider for DT
  arm: mvebu: armada 370/XP adding clock gating support: dt binding

 .../bindings/clock/mvebu-gated-clock.txt           |   43 ++++++++++++++
 arch/arm/boot/dts/armada-370.dtsi                  |    8 +++
 arch/arm/boot/dts/armada-xp.dtsi                   |    7 +++
 arch/arm/mach-mvebu/Kconfig                        |    1 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |   61 ++++++++++++++++++++
 5 files changed, 120 insertions(+)

-- 
1.7.9.5
