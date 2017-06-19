From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Jun 2017 17:36:42 +0200
Subject: [GIT PULL] Improve cp110 clk support on Marvell Armada 7K/8K
Message-ID: <pull.28a1be390fb082d60e88c3234dd7d76fb61438b6.1497886602.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mike, Stephen,

This time I turned the series in a pull request so I removed the
device tree binding part which will be in an other series for Rob
Herring and I also removed the dt part that I will take care of once
you will have pulled this one.

I hope this will be easier for you to apply this way.

Thanks!

Gregory

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (Sat, 13 May 2017 13:19:49 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git refs/heads/clk-cp110

for you to fetch changes up to a45af6d3a98b4d8a2746de13a8db52fb4123bb56:

  clk: mvebu: cp110: add sdio clock to cp-110 system controller (Wed, 31 May 2017 15:19:15 +0200)

----------------------------------------------------------------
Improve cp110 clk support on Marvell Armada 7K/8K

We got more information about the clock controllers and the clock tree
of the CP110 part that we find in the Marvell Armada 7K/8K SoCs. The
clk driver is modified accordingly from this new information.

----------------------------------------------------------------
Gregory CLEMENT (3):
  clk: mvebu: cp110: make failure labels more meaningful
  clk: mvebu: cp110: do not depend anymore of the *-clock-output-names
  clk: mvebu: cp110: introduce a new binding

Konstantin Porotchkin (1):
  clk: mvebu: cp110: add sdio clock to cp-110 system controller

 drivers/clk/mvebu/cp110-system-controller.c | 200 ++++++++++++++-------
 1 file changed, 138 insertions(+), 62 deletions(-)

-- 
git-series 0.9.1
