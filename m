From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 10 Jul 2014 14:24:00 +0300
Subject: [PATCH 0/3] ARM: DTS: omap5-uevm: Enable audio (for 3.17)
Message-ID: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set is to enable audio (finally) on the omap5-uevm. We have been waiting
for the palmas 32K clock driver to make it to upstream, which it did and it is
already in linux-next.

With the three patch we can have audio working on omap5-uevm with linux-next.

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
  ARM: DTS: omap5-uevm: Add node for twl6040 audio codec
  ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040)

 arch/arm/boot/dts/omap5-uevm.dts | 68 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 6 deletions(-)

-- 
2.0.0
