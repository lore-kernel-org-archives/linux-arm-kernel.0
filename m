From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 15 Dec 2011 11:37:37 +0200
Subject: [PATCH 0/2] OMAP4: McBSP: Fix clock reparenting
Message-ID: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

OMAP4 has different clock names compared to OMAP2/3.
Restructure the clock reparenting code for omap2plus in order to be able to
suport OMAP4 clock source selection without breaking upper layer API.

Regards,
Peter
---
Peter Ujfalusi (2):
  OMAP2+: mcbsp: Restructure clk reparenting code
  OMAP4: mcbsp: Clock reparenting support

 arch/arm/mach-omap2/mcbsp.c |   66 +++++++++++++++++++++++++++++++-----------
 1 files changed, 48 insertions(+), 18 deletions(-)

-- 
1.7.8
