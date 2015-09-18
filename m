From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 09:29:03 -0700
Subject: [PATCH 0/2] Fix omap5-uevm WLAN regressions
Message-ID: <1442593745-16725-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are two fixes for omap5-uevm WLAN.

Regards,

Tony

Tony Lindgren (2):
  mfd: twl6040: Fix deferred probe handling for clk32k
  ARM: dts: Fix WLAN regression on omap5-uevm

 arch/arm/boot/dts/omap5-uevm.dts | 51 +++++++++++++++++++++++++++++++---------
 drivers/mfd/twl6040.c            |  2 ++
 2 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.1.4
