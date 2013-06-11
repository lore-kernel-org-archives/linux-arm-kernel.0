From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 11 Jun 2013 10:31:57 +0200
Subject: [PATCH 0/3] ARM: OMAP2+: devices: Silence hwmod lookup failures
 (dmic/mcpdm)
Message-ID: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Small patches to silence the hwmod lookup failures in case when we boot the
kernel on boards where the IPs are not present (OMAP2/3 vs McPDM, DMIC,
HDMI audio).

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
  ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
  ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup
    fails

 arch/arm/mach-omap2/devices.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
1.8.2.1
