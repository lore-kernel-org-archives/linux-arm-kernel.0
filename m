From: ulrich.hecht+renesas@gmail.com (Ulrich Hecht)
Date: Wed, 18 Nov 2015 13:51:05 +0100
Subject: [PATCH 0/2] VIN, ADV7180 for r8a7794/alt
Message-ID: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series adds VIN support for the Alt board.  The hardware configuration
for I2C1 and the video decoder of Alt is exactly identical to that of Silk,
so these are largely identical to Sergei's Silk definitions.

To be applied on top of Horms's "ARM: shmobile: alt: Add pfc pins to DT"
patch.

CU
Uli


Ulrich Hecht (2):
  ARM: shmobile: alt: add I2C1 DT support
  ARM: shmobile: alt: add VIN0, ADV7180 DT support

 arch/arm/boot/dts/r8a7794-alt.dts | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.6.1
