From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 13 Jul 2018 10:30:03 -0700
Subject: [PATCH v2 0/2] Follow up fixes for SCU3 ESB
Message-ID: <20180713173005.19552-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn:

Here's a couple of fixes for things I missed in the
[original-submission]. Sorry about the inconvenience.


Changes since [v1]:

    - Reword commit message for patch 2/2

Thanks,
Andrey Smirnov

[v1] lkml.kernel.org/r/20180712023337.30112-1-andrew.smirnov at gmail.com
[original-submission] lkml.kernel.org/r/20180711050704.11492-1-andrew.smirnov at gmail.com


Andrey Smirnov (2):
  ARM: dts: imx51-zii-scu3-esb: Add switch IRQ line pinumx config
  ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string

 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.17.1
