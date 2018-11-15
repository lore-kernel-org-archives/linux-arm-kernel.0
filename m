From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Nov 2018 14:02:35 -0800
Subject: [PATCH 0/2] Two non-urgent ti-sysc driver fixes
Message-ID: <20181115220237.32129-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are two fixes for ti-sysc for issues I've noticed while testing on
more SoCs. Looks like these can wait until v4.21 merge window.

Regards,

Tony


Tony Lindgren (2):
  bus: ti-sysc: Fix getting optional clocks in clock_roles
  bus: ti-sysc: Add mcasp optional clocks flag

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 drivers/bus/ti-sysc.c                         | 20 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.19.1
