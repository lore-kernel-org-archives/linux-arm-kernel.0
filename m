From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 11 Jul 2018 19:33:35 -0700
Subject: [PATCH 0/2] Follow up fixes for SCU3 ESB
Message-ID: <20180712023337.30112-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn:

Here's a couple of fixes for things I missed in the
[original-submission]. Sorry about the inconvenience.

Thanks,
Andrey Smirnov

[original-submission] lkml.kernel.org/r/20180711050704.11492-1-andrew.smirnov at gmail.com

Andrey Smirnov (2):
  ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
  ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string

 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1
