From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Mar 2014 12:26:35 +0200
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
Message-ID: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch adds hwmod data for omap5 display subsystem. I have tested this on
omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
mainline is missing omap5 HDMI driver.

I do see this when booting:

  omap_hwmod: dss_dispc: cannot be enabled for reset (3)
  omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
  omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
  omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
  omap_hwmod: dss_rfbi: cannot be enabled for reset (3)

But at least DSI works just fine.

 Tomi

Archit Taneja (1):
  ARM: OMAP5: Add omap5 DSS related hwmod data

 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

-- 
1.8.3.2
