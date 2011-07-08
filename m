From: khilman@ti.com (Kevin Hilman)
Date: Fri,  8 Jul 2011 09:11:41 -0700
Subject: [PATCH 0/3] OMAP2+: hwmod_data: I2C updates for v3.1
Message-ID: <1310141504-13688-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

I've separated out the omap_hwmod data changes from Andy's original
series so they can be easier managed with the rest of the hwmod data
changes.

This series applies against v3.0-rc6 and is also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.1/i2c-hwmod-data

Kevin

Andy Green (3):
  I2C: OMAP2+: Set hwmod flags to only allow 16-bit accesses to i2c
  I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
  I2C: OMAP2+: add correct functionality flags to all omap2plus i2c
    dev_attr

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    8 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   13 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   18 ++++++++++++++----
 4 files changed, 40 insertions(+), 5 deletions(-)

-- 
1.7.6
