From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 18:19:25 -0600
Subject: [PATCH 0/5] OMAP: hwmod: second set of core patches for 2.6.37
Message-ID: <20100922001834.8621.76144.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here are a few more hwmod core patches, intended for merging via
Tony's tree for 2.6.37.

I've added these patches to the existing hwmod core series, available
via git at

git://git.pwsan.com/linux-2.6 hwmod_2.6.37

based on v2.6.36-rc5.


regards,

- Paul

---

Benoit Cousson (2):
      OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs
      OMAP: hwmod: Fix softreset for modules with optional clocks

Partha Basak (1):
      OMAP: hwmod: Handle opt clocks node using clk_add_alias

Paul Walmsley (1):
      OMAP: hwmod: improve documentation, clean up function names

Rajendra Nayak (1):
      OMAP: hwmod: Enable module wakeup if in smartidle


 arch/arm/mach-omap2/omap_hwmod.c             |  220 ++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   19 +-
 arch/arm/plat-omap/omap_device.c             |   43 +++++
 3 files changed, 239 insertions(+), 43 deletions(-)
