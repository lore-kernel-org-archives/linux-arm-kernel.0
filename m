From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu,  6 Sep 2012 16:06:16 +0300
Subject: [PATCH 0/2] ARM/dts: omap4 boards: Enable the use of GPO on twl6040
Message-ID: <1346936778-18303-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

twl6040 has GPO functionality. The driver for it is going via MFD tree.
This series adds the needed properties to twl6040 in the dts files so other
drivers can use the GPO lines.

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
