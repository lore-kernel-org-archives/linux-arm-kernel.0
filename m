From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 15:04:01 -0800
Subject: [PATCH 0/4] Fix l4_ls interface clock and enable RTC
Message-ID: <1456182245-1843-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few ti81xx related improvments for v4.6 merge window.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Fix hwmod clock for l4_ls
  ARM: OMAP2+: Add rtc hwmod configuration for ti81xx
  ARM: dts: Add RTC entry for dm814x and dra62x
  ARM: dts: Add RTC entry for dm816x

 arch/arm/boot/dts/dm814x.dtsi              |  7 +++++
 arch/arm/boot/dts/dm816x.dtsi              |  7 +++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 47 ++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.7.0
