From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 20 Jul 2018 21:49:14 +0800
Subject: [GIT PULL] i.MX fixes for 4.18, round 4
Message-ID: <20180720134913.GC4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit de2d9b5284bcb5c159c5882ac69f6bfd4dec7c67:

  soc: imx: gpc: restrict register range for regmap access (2018-07-19 10:24:00 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.18-4

for you to fetch changes up to e01a06c8089132bb4da035c6a83df23916ca3ebf:

  ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch (2018-07-20 10:50:44 +0800)

----------------------------------------------------------------
i.MX fixes for 4.18, round 4:
 - A fix for i.MX6 RDU2 board on the wrong IRQ type of Marvell switch,
   which might result in a race condition in the interrupt handler and
   cause the OS to miss all future events.

----------------------------------------------------------------
Uwe Kleine-K?nig (1):
      ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch

 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
