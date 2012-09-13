From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Sep 2012 10:35:37 +0200
Subject: [GIT PULL 5/5] ARM i.MX SoC updates
In-Reply-To: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
References: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347525337-19115-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc

for you to fetch changes up to 7852399cc666fda491e481575bdbf61bace58f00:

  ARM: i.MX35: Implement camera and keypad clocks (2012-09-06 14:22:59 +0200)

----------------------------------------------------------------
ARM i.MX SoC updates

----------------------------------------------------------------
Alex Gershgorin (1):
      ARM: i.MX35: Implement camera and keypad clocks

Dave Martin (1):
      ARM: mxc: ssi-fiq: Make ssi-fiq.S Thumb-2 compatible

Sascha Hauer (1):
      ARM i.MX53: register CAN clocks

Torben Hohn (1):
      arm imx31: add a few pinmux settings the tt01 needs

 arch/arm/mach-imx/clk-imx35.c              |   11 +++-
 arch/arm/mach-imx/clk-imx51-imx53.c        |   14 ++++-
 arch/arm/plat-mxc/include/mach/iomux-mx3.h |    5 ++
 arch/arm/plat-mxc/ssi-fiq.S                |   89 ++++++++++++++++------------
 4 files changed, 75 insertions(+), 44 deletions(-)
