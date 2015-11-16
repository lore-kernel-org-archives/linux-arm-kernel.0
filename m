From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 16 Nov 2015 18:56:33 +0800
Subject: [PATCH v2 PART-RESEND 0/2] berlin sdhci clock clean up
Message-ID: <1447671395-8023-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add or fix the optional clock property, then remove the CLK_IGNORE_UNUSED
flag for sdio clk(s).

This is a partialy resend of 
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/379457.html

patch3, patch4 has been merged.

Since v1:
 - remove the "mmc: sdhci-pxav3: fix optional clock name" patch to not
   block the clock clean up patches, will send another separate patch
   after talking with HW people.

Jisheng Zhang (2):
  ARM: dts: berlin: correct BG2Q's sdhci2 2nd clock
  ARM: dts: berlin: add 2nd clock for BG2Q sdhci0 and sdhci1

 arch/arm/boot/dts/berlin2q.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.6.2
