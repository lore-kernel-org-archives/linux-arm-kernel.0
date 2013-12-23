From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 23 Dec 2013 11:28:33 +0200
Subject: [PATCH 0/2] ARM: DTS: am335x-evmsk: Audio and MMC1 fix (for 3.13?)
Message-ID: <1387790915-7217-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The audio frequency has been incorrectly set in the DTS file which results
incorrect playback frequency on EVM-SK.

The SD card can not be used without the second patch on 3.13-rc5.

Regards,
Peter
---
Peter Ujfalusi (2):
  ARM: DTS: am335x-evmsk: Correct audio clock frequency
  ARM: dts: am335x-evmsk: Fix mmc1 support

 arch/arm/boot/dts/am335x-evmsk.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
1.8.5.2
