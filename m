From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 19 Jun 2018 14:34:44 +0200
Subject: [PATCH 0/2] clk: Fix switching CPU rate from 300Mhz to 1.2GHz on
 Armada 3700
Message-ID: <20180619123446.694-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

in this series the first patch is the main patch which fixes the case
when switching CPU rate from 300Mhz (or 200M MHz) to 1.2GH. See the
commit log for the details. As this one is a fix, it should be applied
on v4.18-rc.

While I was on this file, I also switch to SPDX license identifier,
this one is fine for 4.19*;

Thanks,

Gregory

Gregory CLEMENT (2):
  clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to
    1.2GHz
  clk: mvebu: armada-37xx-periph: switch to SPDX license identifier

 drivers/clk/mvebu/armada-37xx-periph.c | 43 +++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 4 deletions(-)

-- 
2.17.1
