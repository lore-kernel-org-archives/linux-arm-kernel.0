From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 21 Jul 2014 13:48:10 -0300
Subject: [PATCH 0/6] net: mvpp2: Assorted fixes
Message-ID: <1405961296-5846-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains a set of fixes for issues found while doing some
more intensive tests on the recently accepted mvpp2 ethernet driver.

David: if we are still in time, we'd like to get the driver fixes merged
for v3.17-rc1.

For the devicetree changes, it's already too late for that, since Jason
Cooper has already posted the PRs for v3.17. I'll re-post them when
v3.17-rc1 is released.

As usual, feedback is welcome.

Ezequiel Garcia (3):
  net: mvpp2: Fix the BM pool buffer release check
  net: mvpp2: Simplify BM pool buffers freeing
  ARM: mvebu: Add missing MDIO clock in Armada 375

Marcin Wojtas (3):
  net: mvpp2: Fix the periodic XON enable bit
  net: mvpp2: Enable proper PHY polling and fix port functionality
  ARM: mvebu: Add ethernet aliases required by U-Boot

 arch/arm/boot/dts/armada-375.dtsi    |  3 ++
 drivers/net/ethernet/marvell/mvpp2.c | 65 +++++++++++++++++++++++-------------
 2 files changed, 44 insertions(+), 24 deletions(-)

-- 
2.0.1
