From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 19 Sep 2012 12:43:03 +0300
Subject: [PATCH 0/2] ARM/dts: OMAP4: Enable twl6040 GPO functionality
Message-ID: <1348047785-1681-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following two patch is needed for the twl6040 GPO driver (going via MFD
tree) to work correctly.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM/dts: omap4-sdp: Enable GPO functionality for twl6040
  ARM/dts: omap4-panda: Enable GPO functionality for twl6040

 arch/arm/boot/dts/omap4-panda.dts | 3 +++
 arch/arm/boot/dts/omap4-sdp.dts   | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.7.12
